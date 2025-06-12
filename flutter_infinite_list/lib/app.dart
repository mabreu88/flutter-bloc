// Importa el paquete de Flutter que contiene los widgets de Material Design.
import 'package:flutter/material.dart';

// Importa la página principal de la aplicación que muestra los posts.
import 'package:flutter_infinite_list/posts/view/posts_page.dart';

/// Clase principal de la aplicación.
///
/// Extiende de `MaterialApp`, lo que configura la aplicación para usar
/// el diseño visual y comportamiento de Material Design.
///
/// En este caso, establece `PostsPage` como la pantalla inicial (home).
class App extends MaterialApp {
  /// Constructor constante de la clase `App`.
  ///
  /// Pasa la `PostsPage` como la pantalla inicial.
  const App({super.key}) : super(home: const PostsPage());
}
