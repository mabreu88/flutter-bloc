// Importa el paquete principal de BLoC.
import 'package:bloc/bloc.dart';

// Importa los widgets principales de Flutter.
import 'package:flutter/widgets.dart';

// Importa las herramientas de integración de BLoC con Flutter.
import 'package:flutter_bloc/flutter_bloc.dart';

// Importa la clase principal de tu aplicación (App).
import 'package:flutter_infinite_list/app.dart';

// Importa el observador personalizado que definiste para seguir los eventos y errores de BLoC.
import 'package:flutter_infinite_list/simple_bloc_observer.dart';

/// Punto de entrada principal de la aplicación.
void main() {
  // Establece el observador personalizado para monitorear transiciones y errores
  // en todos los BLoCs de la aplicación.
  Bloc.observer = const SimpleBlocObserver();

  // Ejecuta la aplicación Flutter usando la clase `App` como widget raíz.
  runApp(App());
}
