Map<String, double> calculateValue(double value1, double value2) {
  final addition = value1 + value2;
  final subtraction = value1 - value2;
  final multiplication = value1 * value2;
  final division = value1 / value2;

  return {
    "Penjumlahan": addition,
    "Pengurangan": subtraction,
    "Perkalian": multiplication,
    "Pembagian": division
  };
}
