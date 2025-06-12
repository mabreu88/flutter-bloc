// Importa la librería Equatable para facilitar la comparación de objetos.
import 'package:equatable/equatable.dart';

/// Modelo que representa una publicación (post).
///
/// Incluye un `id`, un `title` (título) y un `body` (contenido).
/// Implementa `Equatable` para permitir comparaciones basadas en valores.
final class Post extends Equatable {
  /// Constructor constante que requiere los tres campos.
  const Post({required this.id, required this.title, required this.body});

  /// Identificador único de la publicación.
  final int id;

  /// Título de la publicación.
  final String title;

  /// Contenido de la publicación.
  final String body;

  /// Sobrescribe `props` para que Equatable pueda comparar objetos `Post`
  /// basándose en sus valores y no en su referencia.
  @override
  List<Object> get props => [id, title, body];
}
