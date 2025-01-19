import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_bansos/components/list_tile_pesanan.dart';
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
                "DAFTAR PESANAN",
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
                return const Center(child: Text("No items found"));
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
                    return ListTilePesanan(barang[index], context);
                  });

              // return Column(
              //   children: [
              //     // FilterStokOwner(),
              //     Expanded(
              //       child: ListView.builder(
              //         itemCount: barang.length,
              //         itemBuilder: (context, index) {
              //           return barang[index].kategori ==
              //                   Provider.of<FilterStockProvider>(context)
              //                       .selectedValue
              //               ? ListTile(
              //                   leading: ClipOval(
              //                     child: Image.asset(
              //                       barang[index].foto,
              //                       width: 50,
              //                       height: 50,
              //                       fit: BoxFit.cover,
              //                       errorBuilder: (context, error, stackTrace) {
              //                         return const AltGambarError(
              //                             lebar: 50, tinggi: 50);
              //                       },
              //                     ),
              //                   ),
              //                   trailing: Badge(
              //                     backgroundColor:
              //                         ShortcutHelper.warnaPrimary(context),
              //                     label: Text(
              //                         barang[index].kategori.toUpperCase()),
              //                   ),
              //                   title: Text(barang[index].nama),
              //                   subtitle: Text("Stok: ${barang[index].jumlah}"),
              //                   onTap: () {
              //                     // UpdateStokOwner(barang[index])
              //                     //     .showBottomSheet(context);
              //                   },
              //                 )
              //               : const SizedBox();
              //         },
              //       ),
              //     ),
              //   ],
              // );
            }));
  }
}
