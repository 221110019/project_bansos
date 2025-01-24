import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_bansos/components/list_tile_pesanan.dart';
import 'package:project_bansos/helper/cakap_helper.dart';
import 'package:project_bansos/helper/shortcut_helper.dart';
import 'package:project_bansos/models/barang_preorder.dart';

class PesananOwner extends StatelessWidget {
  const PesananOwner({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                CakapHelper.tulisan(context)!.o_pesan_1,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ShortcutHelper.warnaPrimary(context),
                ),
              ),
            ],
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('preorder').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                  color: ShortcutHelper.warnaPrimary(context),
                ));
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else if (snapshot.data!.docs.isEmpty ||
                  snapshot.data?.docs == null) {
                return Center(
                    child: Text(CakapHelper.tulisan(context)!.o_pesan_2));
              }
              print(snapshot.data!.docs);
              // print(snapshot.data!.docs[0].data());
              List<BarangPreorder> barang = snapshot.data!.docs.map((doc) {
                final data = doc.data() as Map<String, dynamic>;
                return BarangPreorder.fromMap({
                  'id': doc.id,
                  'namaBarang': data['namaBarang'],
                  'idPembeli': data['idPembeli'],
                  'kategori': data['kategori'],
                  'foto': data['foto'],
                  'jumlah': data['jumlah'],
                  'waktuPengambilan': data['waktuPengambilan']
                });
              }).toList();
              return ListView.builder(
                  itemCount: barang.length,
                  itemBuilder: (context, index) {
                    return listTilePesanan(barang[index], context);
                  });
            }));
  }
}
