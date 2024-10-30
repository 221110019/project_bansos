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

  void tambahBarang() {
    jumlah += 1;
  }

  void kurangBarang() {
    if (jumlah >= 1) {
      jumlah -= 1;
    }
  }
}
