import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_infinite_list/posts/posts.dart';
import 'package:http/http.dart' as http;
import 'package:stream_transform/stream_transform.dart';

part 'post_event.dart';
part 'post_state.dart';

/// Límite de publicaciones que se cargan por solicitud.
const _postLimit = 20;

/// Duración para aplicar "throttle" en los eventos para evitar llamadas excesivas.
const throttleDuration = Duration(milliseconds: 100);

/// Transformador de eventos que combina un throttle con comportamiento droppable.
///
/// Esto permite que durante la duración indicada solo se procese el primer evento,
/// descartando los siguientes hasta que termine el proceso.
EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

/// BLoC que maneja la carga y estado de las publicaciones (`Post`).
///
/// Recibe eventos (`PostEvent`) y emite estados (`PostState`).
class PostBloc extends Bloc<PostEvent, PostState> {
  /// Constructor que requiere un cliente HTTP para hacer las peticiones.
  PostBloc({required http.Client httpClient})
    : _httpClient = httpClient,
      super(const PostState()) {
    // Registra el manejador para el evento PostFetched,
    // usando el transformador throttleDroppable para limitar llamadas rápidas.
    on<PostFetched>(
      _onFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  /// Cliente HTTP privado para realizar las solicitudes a la API.
  final http.Client _httpClient;

  /// Manejador del evento `PostFetched`.
  ///
  /// - Si ya se alcanzó el máximo de posts (`hasReachedMax`), no hace nada.
  /// - Si no, intenta obtener más posts desde el índice actual.
  /// - Si no hay más posts, actualiza el estado indicando que se llegó al máximo.
  /// - Si se obtienen posts, los agrega al estado actual.
  /// - En caso de error, emite un estado de fallo.
  Future<void> _onFetched(PostFetched event, Emitter<PostState> emit) async {
    if (state.hasReachedMax) return;

    try {
      final posts = await _fetchPosts(startIndex: state.posts.length);

      if (posts.isEmpty) {
        // No quedan más posts para cargar.
        return emit(state.copyWith(hasReachedMax: true));
      }

      // Agrega los nuevos posts al estado existente y actualiza el status a success.
      emit(
        state.copyWith(
          status: PostStatus.success,
          posts: [...state.posts, ...posts],
        ),
      );
    } catch (_) {
      // En caso de error al cargar posts.
      emit(state.copyWith(status: PostStatus.failure));
    }
  }

  /// Función privada que hace la solicitud HTTP para obtener posts desde la API.
  ///
  /// Recibe `startIndex` que indica desde qué posición obtener posts.
  /// Solicita un rango limitado de posts definido por `_postLimit`.
  /// Devuelve una lista de objetos `Post`.
  /// Lanza excepción si la respuesta HTTP no es exitosa.
  Future<List<Post>> _fetchPosts({required int startIndex}) async {
    final response = await _httpClient.get(
      Uri.https('jsonplaceholder.typicode.com', '/posts', <String, String>{
        '_start': '$startIndex',
        '_limit': '$_postLimit',
      }),
    );

    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
        final map = json as Map<String, dynamic>;
        return Post(
          id: map['id'] as int,
          title: map['title'] as String,
          body: map['body'] as String,
        );
      }).toList();
    }

    // Si la respuesta no es exitosa, lanza excepción para que el BLoC pueda manejarla.
    throw Exception('Error al cargar publicaciones');
  }
}
