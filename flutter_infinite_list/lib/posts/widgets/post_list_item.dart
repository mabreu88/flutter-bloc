// Importa los widgets y utilidades principales de Flutter.
import 'package:flutter/material.dart';

// Importa el modelo `Post` desde el módulo de posts.
import 'package:flutter_infinite_list/posts/posts.dart';

/// Widget que representa visualmente un solo ítem de una lista de publicaciones.
///
/// Muestra el ID, título y cuerpo de un objeto [Post] usando un `ListTile`.
class PostListItem extends StatelessWidget {
  /// Constructor que recibe un objeto [Post] obligatorio.
  const PostListItem({required this.post, super.key});

  /// El post que se va a mostrar en este ítem.
  final Post post;

  @override
  Widget build(BuildContext context) {
    // Obtiene el tema de texto actual para aplicar estilos según el tema de la app.
    final textTheme = Theme.of(context).textTheme;

    return ListTile(
      // Muestra el ID del post al inicio del ítem.
      leading: Text('${post.id}', style: textTheme.bodySmall),

      // Muestra el título del post como título principal.
      title: Text(post.title),

      // Activa un diseño de tres líneas (title + 2 líneas más).
      isThreeLine: true,

      // Muestra el cuerpo del post como subtítulo.
      subtitle: Text(post.body),

      // Usa un diseño más compacto.
      dense: true,
    );
  }
}
