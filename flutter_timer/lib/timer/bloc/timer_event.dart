// Indica que este archivo forma parte de 'timer_bloc.dart'.
// Esto permite dividir el archivo principal en varios archivos relacionados.
part of 'timer_bloc.dart';

// Clase base sellada (sealed) que representa los eventos que puede recibir el temporizador.
//
// Todas las acciones que afectan al temporizador (iniciar, pausar, reanudar, etc.)
// deben extender de esta clase.
sealed class TimerEvent {
  const TimerEvent();
}

// Evento que indica que el temporizador debe comenzar.
//
// Contiene la duración inicial con la que debe empezar el conteo.
final class TimerStarted extends TimerEvent {
  // Constructor que requiere la duración inicial del temporizador.
  const TimerStarted({required this.duration});

  // Cantidad de segundos con la que inicia el temporizador.
  final int duration;
}

// Evento que indica que el temporizador debe pausarse.
//
// Se emite cuando el usuario detiene temporalmente el temporizador.
final class TimerPaused extends TimerEvent {
  const TimerPaused();
}

// Evento que indica que el temporizador debe reanudarse.
//
// Se emite cuando el usuario reanuda el conteo tras haberlo pausado.
final class TimerResumed extends TimerEvent {
  const TimerResumed();
}

// Evento que indica que el temporizador debe reiniciarse.
//
// Generalmente restablece el temporizador a su estado inicial.
class TimerReset extends TimerEvent {
  const TimerReset();
}

// Evento interno que indica que ha transcurrido un segundo.
//
// Se utiliza internamente por el BLoC para actualizar la duración restante
// en cada tick del temporizador.
class _TimerTicked extends TimerEvent {
  // Constructor que recibe la duración actualizada.
  const _TimerTicked({required this.duration});

  // Nueva duración restante del temporizador.
  final int duration;
}
