import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_bansos/models/barang_stok.dart';

class FirestoreServices {
  FirebaseFirestore db = FirebaseFirestore.instance;
  void createItem(barang) async {
    try {
      await db.collection('barang').doc().set(barang);
    } catch (e) {
      print(e);
    }
  }

  void updateItem(BarangStok barang) async {
    try {
      await db.collection('barang').doc(barang.id).update({
        'nama': barang.nama,
        'foto': barang.foto,
        'jumlah': barang.jumlah,
        'kategori': barang.kategori,
        'deskripsi': barang.deskripsi
      });
    } catch (e) {
      print(e);
    }
  }

  void deleteItem(id) async {
    try {
      await db.collection('barang').doc(id).delete();
    } catch (e) {
      print(e);
    }
  }
}
