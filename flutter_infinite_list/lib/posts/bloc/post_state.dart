// Indica que este archivo forma parte de 'post_bloc.dart'.
part of 'post_bloc.dart';

/// Enum que representa el estado de carga de las publicaciones.
///
/// - `initial`: Estado inicial, antes de cargar publicaciones.
/// - `success`: Las publicaciones se han cargado correctamente.
/// - `failure`: Hubo un error al cargar las publicaciones.
enum PostStatus { initial, success, failure }

/// Estado inmutable que representa la información actual del BLoC de publicaciones.
///
/// Contiene:
/// - `status`: el estado de la carga de datos (initial, success, failure).
/// - `posts`: la lista de publicaciones cargadas hasta el momento.
/// - `hasReachedMax`: indica si se llegó al final de la lista (no hay más publicaciones para cargar).
final class PostState extends Equatable {
  /// Constructor constante que permite valores por defecto.
  const PostState({
    this.status = PostStatus.initial,
    this.posts = const <Post>[],
    this.hasReachedMax = false,
  });

  /// Estado actual del proceso de carga.
  final PostStatus status;

  /// Lista de publicaciones actuales.
  final List<Post> posts;

  /// Indica si se alcanzó el final de la lista de publicaciones.
  final bool hasReachedMax;

  /// Crea una copia del estado actual con valores opcionalmente modificados.
  ///
  /// Este método es útil para mantener la inmutabilidad al actualizar solo una parte del estado.
  PostState copyWith({
    PostStatus? status,
    List<Post>? posts,
    bool? hasReachedMax,
  }) {
    return PostState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  /// Devuelve una representación en texto del estado actual (útil para debugging).
  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${posts.length} }''';
  }

  /// Define qué propiedades deben ser consideradas para comparar estados con Equatable.
  @override
  List<Object> get props => [status, posts, hasReachedMax];
}
