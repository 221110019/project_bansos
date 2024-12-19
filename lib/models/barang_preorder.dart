class BarangPreorder {
  String id;
  String namaBarang;
  String idPembeli;
  String foto;
  int jumlah;
  String kategori;
  DateTime waktuPengambilan;
  BarangPreorder({
    required this.id,
    required this.namaBarang,
    required this.idPembeli,
    required this.foto,
    required this.kategori,
    required this.waktuPengambilan,
    this.jumlah = 0,
  });
  factory BarangPreorder.fromMap(Map<String, dynamic> map) {
    return BarangPreorder(
        id: map['id'],
        namaBarang: map['namaBarang'],
        idPembeli: map['idPembeli'],
        kategori: map['kategori'],
        foto: map['foto'],
        jumlah: map['jumlah'],
        waktuPengambilan: map['waktuPengambilan']);
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'namaBarang': namaBarang,
      'idPembeli': idPembeli,
      'kategori': kategori,
      'foto': foto,
      'jumlah': jumlah,
      'waktuPengambilan': waktuPengambilan
    };
  }
}
