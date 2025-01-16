import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_bansos/models/barang_preorder.dart';
import 'package:project_bansos/models/barang_stok.dart';

class FirestoreServices {
  FirebaseFirestore db = FirebaseFirestore.instance;
  void createItemStock(barang) async {
    try {
      await db.collection('stock_barang').doc().set(barang);
    } catch (e) {
      print(e);
    }
  }

  void updateItemStock(BarangStok barang) async {
    try {
      await db.collection('stock_barang').doc(barang.id).update({
        'nama': barang.nama,
        'foto': barang.foto,
        'jumlah': barang.jumlah,
        'yangDijual': barang.yangDijual,
        'kategori': barang.kategori,
        'deskripsi': barang.deskripsi,
        'harga': barang.harga,
        'kadarluasa': barang.kadarluasa
      });
    } catch (e) {
      print(e);
    }
  }

  void deleteItemStock(id) async {
    try {
      await db.collection("stock_barang").doc(id).delete();
    } catch (e) {
      print(e);
    }
  }

  void createPreorder(barang, BarangStok barangStok, uid) async {
    try {
      await db.collection('preorder').add(barang);
      print(barang['jumlah']);
      barangStok.kurangBanyakBarang(barang['jumlah']);
      barangStok.kurangBanyakBarangYangDijual(barang['jumlah']);
      updateItemStock(barangStok);
    } catch (e) {
      print(e);
    }
  }

  void updatePreorder(BarangPreorder barang) async {
    try {
      await db.collection('preorder').doc(barang.id).update({
        'namaBarang': barang.namaBarang,
        'idPembeli': barang.idPembeli,
        'kategori': barang.kategori,
        'foto': barang.foto,
        'jumlah': barang.jumlah,
        'waktuPengambilan': barang.waktuPengambilan
      });
    } catch (e) {
      print(e);
    }
  }

  void deletePreorder(id) async {
    try {
      await db.collection("preorder").doc(id).delete();
    } catch (e) {
      print(e);
    }
  }
}
