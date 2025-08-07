import 'dart:io';

dynamic information() {
  stdout.write("Name (String): ");
  String? name = stdin.readLineSync();

  stdout.write("Age (int): ");
  int? age = int.tryParse(stdin.readLineSync() ?? '');

  stdout.write("Height in cm (double): ");
  double? height = double.tryParse(stdin.readLineSync() ?? '');

  stdout.write("Are you married? (y/n): ");
  String? marriedInput = stdin.readLineSync();
  bool? isMarried;

  if (marriedInput != null) {
    isMarried = marriedInput.toLowerCase() == 'y';
  }

  print("\n===== Result =====");
  print("Name: ${name ?? 'Invalid'}");
  print("Age: ${age != null ? '$age years old' : 'Invalid'}");
  print("Height: ${height != null ? '$height cm' : 'Invalid'}");
  print("Married: ${isMarried ?? 'Invalid'}");
}
