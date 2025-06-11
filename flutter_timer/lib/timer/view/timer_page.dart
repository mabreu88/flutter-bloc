// Importa los paquetes necesarios de Flutter y Flutter BLoC.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer/ticker.dart';
import 'package:flutter_timer/timer/timer.dart';

// Widget principal de la página del temporizador.
//
// Provee el BLoC a los widgets hijos mediante BlocProvider.
class TimerPage extends StatelessWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Crea una instancia de TimerBloc con un Ticker.
      create: (_) => TimerBloc(ticker: Ticker()),
      child: const TimerView(),
    );
  }
}

// Vista principal del temporizador.
//
// Construye la interfaz con fondo, texto y botones de acción.
class TimerView extends StatelessWidget {
  const TimerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Timer')),
      body: Stack(
        children: [
          const Background(), // Fondo degradado
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 100.0),
                child: Center(child: TimerText()), // Muestra tiempo restante
              ),
              Actions(), // Botones de control
            ],
          ),
        ],
      ),
    );
  }
}

// Widget que muestra el tiempo restante en formato MM:SS.
class TimerText extends StatelessWidget {
  const TimerText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obtiene la duración actual desde el BLoC.
    final duration = context.select((TimerBloc bloc) => bloc.state.duration);

    // Convierte la duración en minutos y segundos.
    final minutesStr = ((duration / 60) % 60).floor().toString().padLeft(
      2,
      '0',
    );
    final secondsStr = (duration % 60).floor().toString().padLeft(2, '0');

    return Text(
      '$minutesStr:$secondsStr',
      style: Theme.of(context).textTheme.displayLarge,
    );
  }
}

// Widget que muestra los botones según el estado del temporizador.
class Actions extends StatelessWidget {
  const Actions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      // Solo reconstruye si el tipo de estado cambia (optimización).
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Usa un switch sobre el estado actual para mostrar botones adecuados.
            ...switch (state) {
              // Estado inicial: muestra botón de reproducir.
              TimerInitial() => [
                FloatingActionButton(
                  child: const Icon(Icons.play_arrow),
                  onPressed: () => context.read<TimerBloc>().add(
                    TimerStarted(duration: state.duration),
                  ),
                ),
              ],

              // En ejecución: muestra pausa y reiniciar.
              TimerRunInProgress() => [
                FloatingActionButton(
                  child: const Icon(Icons.pause),
                  onPressed: () =>
                      context.read<TimerBloc>().add(const TimerPaused()),
                ),
                FloatingActionButton(
                  child: const Icon(Icons.replay),
                  onPressed: () =>
                      context.read<TimerBloc>().add(const TimerReset()),
                ),
              ],

              // En pausa: muestra reanudar y reiniciar.
              TimerRunPause() => [
                FloatingActionButton(
                  child: const Icon(Icons.play_arrow),
                  onPressed: () =>
                      context.read<TimerBloc>().add(const TimerResumed()),
                ),
                FloatingActionButton(
                  child: const Icon(Icons.replay),
                  onPressed: () =>
                      context.read<TimerBloc>().add(const TimerReset()),
                ),
              ],

              // Finalizado: solo muestra reiniciar.
              TimerRunComplete() => [
                FloatingActionButton(
                  child: const Icon(Icons.replay),
                  onPressed: () =>
                      context.read<TimerBloc>().add(const TimerReset()),
                ),
              ],
            },
          ],
        );
      },
    );
  }
}

// Widget de fondo con un degradado vertical azul.
class Background extends StatelessWidget {
  const Background({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue.shade50, Colors.blue.shade500],
        ),
      ),
    );
  }
}
