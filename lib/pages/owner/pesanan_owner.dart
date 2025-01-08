import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_bansos/components/alt_gambar_error.dart';
import 'package:project_bansos/helper/shortcut_helper.dart';
import 'package:project_bansos/models/barang_stok.dart';
import 'package:project_bansos/pages/owner/stok/update_stok_owner.dart';
import 'package:project_bansos/provider/filter_stock_provider.dart';
import 'package:provider/provider.dart';

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
            stream: FirebaseFirestore.instance
                .collection('stock_barang')
                .snapshots(),
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
              // print(snapshot.data!.docs[0].data());
              List<BarangStok> barang = snapshot.data!.docs.map((doc) {
                final data = doc.data() as Map<String, dynamic>;
                return BarangStok.fromMap({
                  'id': doc.id,
                  'nama': data['nama'],
                  'foto': data['foto'],
                  'jumlah': data['jumlah'],
                  'yangDijual': data['yangDijual'],
                  'kategori': data['kategori'],
                  'deskripsi': data['deskripsi']
                });
              }).toList();

              return Column(
                children: [
                  // FilterStokOwner(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: barang.length,
                      itemBuilder: (context, index) {
                        return barang[index].kategori ==
                                Provider.of<FilterStockProvider>(context)
                                    .selectedValue
                            ? ListTile(
                                leading: ClipOval(
                                  child: Image.asset(
                                    barang[index].foto,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const AltGambarError(
                                          lebar: 50, tinggi: 50);
                                    },
                                  ),
                                ),
                                trailing: Badge(
                                  backgroundColor:
                                      ShortcutHelper.warnaPrimary(context),
                                  label: Text(
                                      barang[index].kategori.toUpperCase()),
                                ),
                                title: Text(barang[index].nama),
                                subtitle: Text("Stok: ${barang[index].jumlah}"),
                                onTap: () {
                                  UpdateStokOwner(barang[index])
                                      .showBottomSheet(context);
                                },
                              )
                            : const SizedBox();
                      },
                    ),
                  ),
                ],
              );
            }));
  }
}
