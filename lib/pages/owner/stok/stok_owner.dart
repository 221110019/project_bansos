import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_bansos/components/alt_gambar_error.dart';
import 'package:project_bansos/components/tombol_custom.dart';
import 'package:project_bansos/helper/cakap_helper.dart';
import 'package:project_bansos/helper/exp_stok_helper.dart';
import 'package:project_bansos/helper/shortcut_helper.dart';
import 'package:project_bansos/models/barang_stok.dart';
import 'package:project_bansos/pages/owner/stok/filter_stok_owner.dart';
import 'package:project_bansos/pages/owner/stok/tambah_stok_owner.dart';
import 'package:project_bansos/pages/owner/stok/update_stok_owner.dart';
import 'package:project_bansos/provider/filter_stock_provider.dart';
import 'package:project_bansos/provider/owner_bottom_nav_provider.dart';
import 'package:provider/provider.dart';

class StokOwner extends StatefulWidget {
  const StokOwner({super.key});

  @override
  StokOwnerState createState() => StokOwnerState();
}

class StokOwnerState extends State<StokOwner> {
  late Future<List<BarangStok>> futureBarangStok;
  List<BarangStok> semuaBarang = [];
  List<BarangStok> sampleBarang = [];
  TextEditingController hargaController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    hargaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                CakapHelper.tulisan(context)!.o_stok_1,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ShortcutHelper.warnaPrimary(context),
                ),
              ),
              TombolCustom(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const TambahStokOwner()));
                },
                child: Icon(
                  Icons.assignment_add,
                  color: ShortcutHelper.warnaOnPrimary(context),
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
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                    child: Text(CakapHelper.tulisan(context)!.o_pesan_2));
              }
              // print(snapshot.data!.docs[0].data());
              List<BarangStok> barang = snapshot.data!.docs
                  .map((doc) => BarangStok.fromMap({
                        'id': doc.id,
                        'nama': doc['nama'],
                        'foto': doc['foto'],
                        'jumlah': doc['jumlah'],
                        'yangDijual': doc['yangDijual'],
                        'kategori': doc['kategori'],
                        'deskripsi': doc['deskripsi'],
                        'harga': doc['harga'],
                        'kadarluasa': doc['kadarluasa']
                      }))
                  .toList();
              context.read<OwnerMetaProvider>().countExp(barang.where((item) {
                    return BarangStok.cekBarangExpired([item]);
                  }).length);
              context.read<OwnerMetaProvider>().countStokHabis(barang
                  .where((item) => BarangStok.cekSisaStok([item]))
                  .length);
              return Column(
                children: [
                  const FilterStokOwner(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: barang.length,
                      itemBuilder: (context, index) {
                        return barang[index].kategori ==
                                Provider.of<FilterStockProvider>(context)
                                    .selectedValue
                            ? Card(
                                elevation: 0.45,
                                surfaceTintColor:
                                    ShortcutHelper.warnaPrimary(context),
                                child: ListTile(
                                  leading: Badge(
                                    alignment: Alignment.topLeft,
                                    backgroundColor:
                                        ShortcutHelper.warnaPrimary(context),
                                    label: Text(
                                        barang[index].kategori.toUpperCase()),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.file(
                                        File(barang[index].foto),
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const AltGambarError(
                                              lebar: 50, tinggi: 50);
                                        },
                                      ),
                                    ),
                                  ),
                                  title: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            barang[index].nama.toUpperCase(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w900),
                                          ),
                                          Text(
                                            ShortcutHelper.rupiahkan(
                                                barang[index].harga),
                                            style:
                                                const TextStyle(fontSize: 10),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              "${barang[index].jumlah} ${CakapHelper.tulisan(context)!.o_home_1.toLowerCase()} >"),
                                          Text(
                                              " ${barang[index].jumlah - barang[index].yangDijual} ${CakapHelper.tulisan(context)!.o_stok_2} +"),
                                          Text(
                                              "${barang[index].yangDijual} ${CakapHelper.tulisan(context)!.o_stok_3}"),
                                        ],
                                      ),
                                    ],
                                  ),
                                  subtitle: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      barang[index].kadarluasa != null
                                          ? Text(
                                              '${CakapHelper.tulisan(context)!.o_dash_5} : ${IndomieHelper.waktuExpired(context, barang[index].kadarluasa!.toDate())}',
                                              style:
                                                  const TextStyle(fontSize: 10),
                                            )
                                          : const SizedBox()
                                    ],
                                  ),
                                  onTap: () {
                                    UpdateStokOwner(
                                            barang[index], hargaController)
                                        .showBottomSheet(context);
                                  },
                                ),
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
