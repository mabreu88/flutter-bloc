// Importa utilidades para trabajar con streams y temporizadores.
import 'dart:async';

// Importa la biblioteca BLoC para manejar eventos y estados.
import 'package:bloc/bloc.dart';

// Importa Equatable para facilitar la comparación de objetos.
import 'package:equatable/equatable.dart';

// Importa el ticker personalizado que emite ticks (segundos).
import 'package:flutter_timer/ticker.dart';

// Incluye los archivos que definen los eventos y estados del TimerBloc.
part 'timer_event.dart';
part 'timer_state.dart';

// Clase BLoC que maneja la lógica del temporizador.
//
// Esta clase responde a eventos como iniciar, pausar, reanudar o reiniciar,
// y emite los estados correspondientes del temporizador.
class TimerBloc extends Bloc<TimerEvent, TimerState> {
  // Constructor que recibe una instancia de [Ticker] y configura
  // los manejadores de eventos.
  TimerBloc({required Ticker ticker})
    : _ticker = ticker,
      super(const TimerInitial(_duration)) {
    on<TimerStarted>(_onStarted); // Escucha cuando se inicia el temporizador
    on<TimerPaused>(_onPaused); // Escucha cuando se pausa
    on<TimerResumed>(_onResumed); // Escucha cuando se reanuda
    on<TimerReset>(_onReset); // Escucha cuando se reinicia
    on<_TimerTicked>(_onTicked); // Escucha cada tick emitido por el Ticker
  }

  // Referencia al ticker que emite los ticks.
  final Ticker _ticker;

  // Duración inicial por defecto del temporizador (en segundos).
  static const int _duration = 60;

  // Suscripción al stream de ticks del ticker.
  StreamSubscription<int>? _tickerSubscription;

  // Cancela la suscripción al ticker cuando se cierra el BLoC.
  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  // Maneja el evento TimerStarted.
  //
  // Inicia el temporizador y comienza a escuchar los ticks del ticker.
  void _onStarted(TimerStarted event, Emitter<TimerState> emit) {
    emit(TimerRunInProgress(event.duration));
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(ticks: event.duration)
        .listen((duration) => add(_TimerTicked(duration: duration)));
  }

  // Maneja el evento TimerPaused.
  //
  // Pausa la suscripción al ticker y emite el estado de pausa.
  void _onPaused(TimerPaused event, Emitter<TimerState> emit) {
    if (state is TimerRunInProgress) {
      _tickerSubscription?.pause();
      emit(TimerRunPause(state.duration));
    }
  }

  // Maneja el evento TimerResumed.
  //
  // Reanuda la suscripción al ticker y vuelve al estado en progreso.
  void _onResumed(TimerResumed resume, Emitter<TimerState> emit) {
    if (state is TimerRunPause) {
      _tickerSubscription?.resume();
      emit(TimerRunInProgress(state.duration));
    }
  }

  // Maneja el evento TimerReset.
  //
  // Cancela cualquier suscripción y vuelve al estado inicial con duración por defecto.
  void _onReset(TimerReset event, Emitter<TimerState> emit) {
    _tickerSubscription?.cancel();
    emit(const TimerInitial(_duration));
  }

  // Maneja el evento _TimerTicked.
  //
  // Emite un nuevo estado en progreso o finalizado, según la duración restante.
  void _onTicked(_TimerTicked event, Emitter<TimerState> emit) {
    emit(
      event.duration > 0
          ? TimerRunInProgress(event.duration)
          : const TimerRunComplete(),
    );
  }
}
