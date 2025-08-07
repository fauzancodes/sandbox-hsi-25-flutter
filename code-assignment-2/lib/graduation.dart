String checkGraduation(int score) {
  if (score >= 75) return "Lulus";

  if (score >= 60 && score < 75) return "Remedial";

  if (score < 60) return "Tidak Lulus";

  return "Tidak diketahui";
}
