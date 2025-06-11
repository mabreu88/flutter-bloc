// Clase que simula un contador regresivo (ticker).
//
// Esta clase se puede utilizar, por ejemplo, para contar segundos en un
// temporizador o en una cuenta regresiva. Utiliza un `Stream` que emite
// valores enteros decrecientes una vez por segundo.
class Ticker {
  // Constructor constante de la clase [Ticker].
  //
  // No requiere parámetros y puede ser utilizado como una constante.
  const Ticker();

  // Retorna un [Stream] que emite un valor entero cada segundo,
  // comenzando desde [ticks - 1] hasta 0.
  //
  // El parámetro [ticks] indica la cantidad total de emisiones que realizará
  // el stream, es decir, el número de segundos de la cuenta regresiva.
  //
  // Por ejemplo, si [ticks] es 3, el stream emitirá: `2, 1, 0`, uno por segundo.
  //
  // Este stream finaliza automáticamente después de emitir [ticks] valores.
  Stream<int> tick({required int ticks}) {
    return Stream.periodic(
      const Duration(seconds: 1),
      (x) => ticks - x - 1,
    ).take(ticks);
  }
}
