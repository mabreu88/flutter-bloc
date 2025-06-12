// ignore_for_file: avoid_print
// Ignora la advertencia de usar 'print', ya que en producción se recomienda usar un sistema de logs.

// Importa el paquete de BLoC necesario para observar eventos y transiciones.
import 'package:bloc/bloc.dart';

/// Un observador personalizado para BLoC que permite monitorear transiciones
/// de estado y errores dentro de cualquier BLoC o Cubit.
///
/// Esta clase es útil para depurar y entender cómo fluyen los estados
/// en tu aplicación durante el desarrollo.
class SimpleBlocObserver extends BlocObserver {
  // Constructor constante sin parámetros.
  const SimpleBlocObserver();

  /// Se ejecuta automáticamente cada vez que un BLoC realiza una transición de estado.
  ///
  /// Parámetros:
  /// - [bloc]: el BLoC que emitió la transición.
  /// - [transition]: la transición que contiene el estado anterior, el evento y el nuevo estado.
  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    // Imprime la transición en consola (útil para debug).
    print(transition);
  }

  /// Se ejecuta automáticamente cuando ocurre un error dentro de un BLoC o Cubit.
  ///
  /// Parámetros:
  /// - [bloc]: el BLoC donde ocurrió el error.
  /// - [error]: el objeto de error lanzado.
  /// - [stackTrace]: la traza del error (útil para depuración).
  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    // Imprime el error en consola (útil para debug).
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}
