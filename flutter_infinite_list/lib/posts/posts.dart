// Importa la librería `equatable`, que facilita la comparación de objetos
// sobrescribiendo la igualdad (`==`) y el hashCode automáticamente.
import 'package:equatable/equatable.dart';

/// Modelo que representa un post (publicación).
///
/// Extiende de `Equatable` para que las instancias de esta clase
/// se puedan comparar por valor en lugar de por referencia.
///
/// Esto es útil especialmente en BLoC y listas, donde la igualdad
/// entre objetos es importante para detectar cambios de estado.
final class Post extends Equatable {
  /// Constructor constante que recibe los valores requeridos del post.
  const Post({required this.id, required this.title, required this.body});

  /// Identificador único del post.
  final int id;

  /// Título del post.
  final String title;

  /// Cuerpo o contenido del post.
  final String body;

  /// Sobrescribe las propiedades que se usarán para comparar instancias de `Post`.
  ///
  /// Esto le dice a `Equatable` que dos objetos `Post` son iguales si tienen
  /// el mismo `id`, `title` y `body`.
  @override
  List<Object> get props => [id, title, body];
}
