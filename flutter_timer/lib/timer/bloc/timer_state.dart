// Indica que este archivo forma parte de 'timer_bloc.dart'.
// Esto permite dividir el código del BLoC en múltiples archivos usando `part` y `part of`.
part of 'timer_bloc.dart';

// Clase base sellada (sealed) que representa el estado del temporizador.
//
// Todas las clases que extienden de [TimerState] comparten el campo [duration],
// que indica cuántos segundos quedan en el temporizador.
sealed class TimerState extends Equatable {
  // Constructor constante que recibe la duración restante.
  const TimerState(this.duration);

  // Duración restante del temporizador, en segundos.
  final int duration;

  // Define las propiedades usadas para comparar instancias de estados.
  @override
  List<Object> get props => [duration];
}

// Estado inicial del temporizador.
//
// Se utiliza cuando el temporizador aún no ha comenzado.
final class TimerInitial extends TimerState {
  // Constructor que recibe la duración inicial.
  const TimerInitial(super.duration);

  @override
  String toString() => 'TimerInitial { duration: $duration }';
}

// Estado cuando el temporizador está pausado.
//
// Se utiliza cuando el temporizador fue iniciado pero se encuentra detenido momentáneamente.
final class TimerRunPause extends TimerState {
  const TimerRunPause(super.duration);

  @override
  String toString() => 'TimerRunPause { duration: $duration }';
}

// Estado cuando el temporizador está en curso.
//
// Se utiliza cuando el temporizador se está ejecutando activamente.
final class TimerRunInProgress extends TimerState {
  const TimerRunInProgress(super.duration);

  @override
  String toString() => 'TimerRunInProgress { duration: $duration }';
}

// Estado cuando el temporizador ha llegado a cero.
//
// Representa la finalización del conteo.
final class TimerRunComplete extends TimerState {
  // Constructor que establece automáticamente la duración en 0.
  const TimerRunComplete() : super(0);
}
