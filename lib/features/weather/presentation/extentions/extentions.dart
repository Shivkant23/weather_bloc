enum TemperatureUnits { fahrenheit, celsius }

extension TemperatureUnitsX on TemperatureUnits {
  bool get isFahrenheit => this == TemperatureUnits.fahrenheit;
  bool get isCelsius => this == TemperatureUnits.celsius;
}



// import 'package:flutter/material.dart';

// extension on Color {
//   Color brighten([int percent = 10]) {
//     assert(
//       1 <= percent && percent <= 100,
//       'percentage must be between 1 and 100',
//     );
//     final p = percent / 100;
//     return Color.fromARGB(
//       alpha,
//       red + ((255 - red) * p).round(),
//       green + ((255 - green) * p).round(),
//       blue + ((255 - blue) * p).round(),
//     );
//   }
// }

// extension on Weather {
//   String formattedTemperature(TemperatureUnits units) {
//     return '''${temperature.value.toStringAsPrecision(2)}°${units.isCelsius ? 'C' : 'F'}''';
//   }
// }
