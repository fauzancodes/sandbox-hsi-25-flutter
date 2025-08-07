
import 'package:code_assignment_2/calculation.dart';
import 'package:code_assignment_2/graduation.dart';
import 'package:code_assignment_2/handling.dart';
import 'package:code_assignment_2/student.dart';

void main() {
  print("\n");
  print("Soal Nomor 1");
  final calculationResult = calculateValue(14, 97);
  print("Penjumlahan: ${calculationResult["Penjumlahan"]}");
  print("Pengurangan: ${calculationResult["Pengurangan"]}");
  print("Pembagian: ${calculationResult["Pembagian"]}");
  print("Perkalian: ${calculationResult["Perkalian"]}");

  print("\n");
  print("Soal Nomor 2");
  final graduation = checkGraduation(80);
  print("Kelulusan: $graduation");

  print("\n");
  print("Soal Nomor 3");
  final mahasiswa = Mahasiswa("Fauzan", "123456789", "Teknik Geofisika");
  mahasiswa.tampilkanInfo();

  print("\n");
  print("Soal Nomor 4");
  final divideByZeroResult = divideByZero(10);
  print("divideByZeroResult: $divideByZeroResult");
}
