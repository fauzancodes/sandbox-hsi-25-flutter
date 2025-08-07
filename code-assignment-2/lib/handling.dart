dynamic divideByZero(int value) {
  try {
    return value ~/ 0;
  } catch (error) {
    print("Terjadi kesalahan: $error");
  }
}
