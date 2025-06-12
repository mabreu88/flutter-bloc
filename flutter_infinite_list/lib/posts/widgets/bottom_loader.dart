// Importa los widgets de Flutter necesarios.
import 'package:flutter/material.dart';

/// Widget que muestra un indicador de carga (spinner) centrado y pequeño.
///
/// Se utiliza comúnmente en la parte inferior de una lista para indicar que
/// se están cargando más datos (por ejemplo, cuando se hace scroll infinito).
class BottomLoader extends StatelessWidget {
  /// Constructor constante.
  const BottomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      // Centra el contenido (el spinner) dentro del widget.
      child: SizedBox(
        height: 24, // Altura del spinner.
        width: 24, // Ancho del spinner.
        // Spinner circular con un grosor fino.
        child: CircularProgressIndicator(strokeWidth: 1.5),
      ),
    );
  }
}
