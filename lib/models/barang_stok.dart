class BarangStok {
  int id;
  String nama;
  String foto;
  int jumlah;
  String kategori;
  String deskripsi;
  BarangStok({
    required this.id,
    required this.nama,
    required this.foto,
    required this.kategori,
    required this.deskripsi,
    this.jumlah = 0,
  });
  factory BarangStok.fromMap(Map<String, dynamic> map) {
    return BarangStok(
        id: map['id'],
        nama: map['nama'],
        kategori: map['kategori'],
        foto: map['foto'],
        jumlah: map['jumlah'],
        deskripsi: map['deskripsi']);
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'kategori': kategori,
      'foto': foto,
      'jumlah': jumlah,
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
}
