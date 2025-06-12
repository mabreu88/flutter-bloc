// Indica que este archivo forma parte de 'post_bloc.dart'.
part of 'post_bloc.dart';

/// Clase base para los eventos relacionados con los posts.
///
/// Se utiliza como superclase para definir diferentes tipos de eventos.
/// Hereda de Equatable para facilitar la comparación y evitar duplicados.
sealed class PostEvent extends Equatable {
  @override
  List<Object> get props => [];
}

/// Evento que indica que se deben obtener más publicaciones.
///
/// Se dispara típicamente cuando el usuario hace scroll cerca del final de la lista,
/// para solicitar más posts al repositorio o API.
final class PostFetched extends PostEvent {}
