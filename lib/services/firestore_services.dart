import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_bansos/models/barang_stok.dart';

class FirestoreServices {
  FirebaseFirestore db = FirebaseFirestore.instance;
  void createItem(barang, collection) async {
    try {
      await db.collection(collection).doc().set(barang);
    } catch (e) {
      print(e);
    }
  }

  void updateItem(BarangStok barang, collection) async {
    try {
      await db.collection(collection).doc(barang.id).update({
        'nama': barang.nama,
        'foto': barang.foto,
        'jumlah': barang.jumlah,
        'yangDijual': barang.yangDijual,
        'kategori': barang.kategori,
        'deskripsi': barang.deskripsi
      });
    } catch (e) {
      print(e);
    }
  }

  void deleteItem(id, collection) async {
    try {
      await db.collection(collection).doc(id).delete();
    } catch (e) {
      print(e);
    }
  }
}
