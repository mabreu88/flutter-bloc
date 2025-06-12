// Importa los widgets principales de Flutter.
import 'package:flutter/material.dart';

// Importa las herramientas de BLoC para Flutter.
import 'package:flutter_bloc/flutter_bloc.dart';

// Importa el BLoC responsable de manejar la lógica de los posts.
import 'package:flutter_infinite_list/posts/bloc/post_bloc.dart';

// Importa la lista de posts que se mostrará en pantalla.
import 'package:flutter_infinite_list/posts/view/posts_list.dart';

// Importa la librería HTTP para realizar peticiones a una API.
import 'package:http/http.dart' as http;

/// Página principal que muestra la lista de publicaciones (`PostsList`)
/// y configura el BLoC necesario para obtener los datos.
class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Usa un Scaffold básico con solo un body (sin AppBar).
      body: BlocProvider(
        // Crea el BLoC y lo inyecta en el árbol de widgets.
        // Se le pasa un cliente HTTP para hacer las peticiones a la API.
        create: (_) =>
            PostBloc(httpClient: http.Client())
              ..add(PostFetched()), // Lanza el evento inicial al crear el BLoC.
        // Widget que mostrará la lista de publicaciones.
        child: const PostsList(),
      ),
    );
  }
}
