class Mahasiswa {
  String nama;
  String nim;
  String jurusan;

  Mahasiswa(this.nama, this.nim, this.jurusan);

  void tampilkanInfo() {
    print("nama: $nama");
    print("nim: $nim");
    print("jurusan: $jurusan");
  }
}
