// Importa el paquete de Flutter necesario para crear interfaces de usuario.
import 'package:flutter/material.dart';

// Importa la página TimerPage, que será la pantalla principal de la app.
import 'package:flutter_timer/timer/timer.dart';

// Clase principal de la aplicación Flutter.
// Extiende StatelessWidget, lo que significa que no tiene estado mutable.
class App extends StatelessWidget {
  // Constructor constante de la clase App.
  const App({super.key});

  // Método que construye el widget de la aplicación.
  // Retorna un MaterialApp con configuración básica: título, tema y página principal.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Título de la aplicación, útil para accesibilidad y tareas del sistema.
      title: 'Flutter Timer',

      // Tema visual de la aplicación.
      theme: ThemeData(
        // Define un esquema de colores claro con un color primario personalizado.
        colorScheme: const ColorScheme.light(
          primary: Color.fromRGBO(72, 74, 126, 1), // Azul oscuro personalizado.
        ),
      ),

      // Página de inicio de la aplicación, que en este caso es TimerPage.
      home: const TimerPage(),
    );
  }
}
