class BarangStok {
  String id;
  String nama;
  String foto;
  int jumlah;
  int yangDijual;
  String kategori;
  String deskripsi;
  BarangStok(
      {required this.id,
      required this.nama,
      required this.foto,
      required this.kategori,
      required this.deskripsi,
      this.jumlah = 0,
      this.yangDijual = 0});
  factory BarangStok.fromMap(Map<String, dynamic> map) {
    return BarangStok(
        id: map['id'],
        nama: map['nama'],
        kategori: map['kategori'],
        foto: map['foto'],
        jumlah: map['jumlah'],
        yangDijual: map['yangDijual'],
        deskripsi: map['deskripsi']);
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'kategori': kategori,
      'foto': foto,
      'jumlah': jumlah,
      'yangDijual': yangDijual,
      'deskripsi': deskripsi
    };
  }

  void tambahBarang() {
    jumlah += 1;
  }

  void kurangBarang() {
    if (jumlah >= 1) {
      jumlah -= 1;
    }
  }

  void kurangBanyakBarang(int value) {
    jumlah -= value;
  }

  void kurangBanyakBarangYangDijual(int value) {
    yangDijual -= value;
  }

  void tambahYangDijual() {
    yangDijual += 1;
  }

  void kurangYangDijual() {
    if (yangDijual >= 1) {
      yangDijual -= 1;
    }
  }
}
