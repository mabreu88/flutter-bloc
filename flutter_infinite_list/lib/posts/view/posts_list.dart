// Importa los widgets de Flutter.
import 'package:flutter/material.dart';

// Importa las herramientas de BLoC.
import 'package:flutter_bloc/flutter_bloc.dart';

// Importa el BLoC que maneja los estados y eventos de los posts.
import 'package:flutter_infinite_list/posts/bloc/post_bloc.dart';

// Importa el widget que se muestra al final de la lista mientras se cargan más posts.
import 'package:flutter_infinite_list/posts/widgets/bottom_loader.dart';

// Importa el widget que representa visualmente un solo post.
import 'package:flutter_infinite_list/posts/widgets/post_list_item.dart';

/// Widget que muestra una lista de publicaciones (`Post`) con scroll infinito.
///
/// Usa un `ScrollController` para detectar cuándo se está llegando al fondo
/// y así cargar más elementos a través de un evento al `PostBloc`.
class PostsList extends StatefulWidget {
  const PostsList({super.key});

  @override
  State<PostsList> createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  // Controlador del scroll que permite escuchar el desplazamiento de la lista.
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Agrega un listener para detectar cuándo se hace scroll.
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    // Usa BlocBuilder para reconstruir la UI cuando cambia el estado del PostBloc.
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        switch (state.status) {
          // En caso de error al cargar los posts.
          case PostStatus.failure:
            return const Center(child: Text('Error al cargar publicaciones'));

          // En caso de carga exitosa de los posts.
          case PostStatus.success:
            // Si no hay publicaciones.
            if (state.posts.isEmpty) {
              return const Center(child: Text('No hay publicaciones'));
            }

            // Si hay publicaciones, se muestran en una lista.
            return ListView.builder(
              // Crea cada ítem de la lista.
              itemBuilder: (BuildContext context, int index) {
                // Si el índice es mayor o igual a la cantidad de posts cargados,
                // muestra un loader al final para indicar que se están cargando más.
                return index >= state.posts.length
                    ? const BottomLoader()
                    : PostListItem(post: state.posts[index]);
              },
              // Si ya se alcanzó el máximo de posts, no se suma el loader extra.
              itemCount: state.hasReachedMax
                  ? state.posts.length
                  : state.posts.length + 1,
              controller: _scrollController, // Asocia el controlador de scroll.
            );

          // Mientras se cargan los primeros posts.
          case PostStatus.initial:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    // Libera los recursos del scroll controller al destruir el widget.
    _scrollController.dispose();
    super.dispose();
  }

  /// Función que se ejecuta cada vez que se detecta scroll.
  /// Si se llega cerca del fondo, se lanza un evento `PostFetched`.
  void _onScroll() {
    if (_isBottom) {
      context.read<PostBloc>().add(PostFetched());
    }
  }

  /// Verifica si el usuario ha llegado al 90% del final de la lista.
  bool get _isBottom {
    if (!_scrollController.hasClients) return false;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;

    return currentScroll >= (maxScroll * 0.9);
  }
}
