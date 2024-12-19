import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_bansos/components/list_tile_pesanan.dart';
import 'package:project_bansos/helper/shortcut_helper.dart';
import 'package:project_bansos/models/barang_preorder.dart';

class Pesanan extends StatefulWidget {
  const Pesanan({super.key});

  @override
  State<Pesanan> createState() => _PesananState();
}

class _PesananState extends State<Pesanan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesanan'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('preorder').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: ShortcutHelper.warnaPrimary(context),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("No items found"));
            }
            print('hai');
            List<BarangPreorder> listPesanan = snapshot.data!.docs
                .map((doc) => BarangPreorder.fromMap({
                      'id': doc.id,
                      'namaBarang': doc['namaBarang'],
                      'idPembeli': doc['idPembeli'],
                      'kategori': doc['kategori'],
                      'foto': doc['foto'],
                      'jumlah': doc['jumlah'],
                      'waktuPengambilan':
                          (doc['waktuPengambilan'] as Timestamp).toDate()
                    }))
                .toList();
            return ListView.builder(
                itemCount: listPesanan.length,
                itemBuilder: (context, index) {
                  return ListTilePesanan(listPesanan[index]);
                });
          }),
    );
  }
}
