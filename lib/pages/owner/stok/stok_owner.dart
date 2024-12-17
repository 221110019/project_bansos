import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_bansos/components/theme_switch.dart';
import 'package:project_bansos/components/tombol_custom.dart';
import 'package:project_bansos/database/database_stok.dart';
import 'package:project_bansos/helper/shortcut_helper.dart';
import 'package:project_bansos/models/barang_stok.dart';
import 'package:project_bansos/pages/owner/stok/filter_stok_owner.dart';
import 'package:project_bansos/pages/owner/stok/tambah_stok_owner.dart';
import 'package:project_bansos/pages/owner/stok/update_stok_owner.dart';
import 'package:project_bansos/provider/filter_stock_provider.dart';
import 'package:provider/provider.dart';

class StokOwner extends StatefulWidget {
  const StokOwner({super.key});

  @override
  _StokOwnerState createState() => _StokOwnerState();
}

class _StokOwnerState extends State<StokOwner> {
  late Future<List<BarangStok>> futureBarangStok;
  List<BarangStok> semuaBarang = [];
  List<BarangStok> sampleBarang = [];

  @override
  void initState() {
    super.initState();
    // futureBarangStok = loadBarangData();
  }

  // Future<List<BarangStok>> loadBarangData() async {
  //   List<BarangStok> data = await BarangStokDB().read();
  //   setState(() {
  //     semuaBarang = data;
  //     sampleBarang = data;
  //   });
  //   return data;
  // }

  // void filterStok(String selectedValue) {
  // print("Filtering with value: $selectedValue");
  // List<BarangStok> filteredList;
  // if (selectedValue == 'Kue') {
  //   filteredList =
  //       semuaBarang.where((barang) => barang.kategori == "Kue").toList();
  // } else if (selectedValue == 'Alat') {
  //   filteredList =
  //       semuaBarang.where((barang) => barang.kategori == "Alat").toList();
  // } else if (selectedValue == 'Acak') {
  //   filteredList =
  //       semuaBarang.where((barang) => barang.kategori == "Acak").toList();
  // } else {
  //   filteredList = semuaBarang;
  // }
  // setState(() {
  //   sampleBarang = filteredList;
  // });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // floatingActionButton: IconButton(
        //   icon: Icon(Icons.refresh),
        //   // onPressed: () async{
        //   //           int result = await BarangStokDB().read();
        //   //           if (result > 0) {
        //   //             print("berhasil hapus");
        //   //             Navigator.pop(context);
        //   //           } else {
        //   //             print("gagal hapus");
        //   onPressed: loadBarangData,
        //   // }
        //   // },
        // ),
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "STOK BARANG",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ShortcutHelper.warnaPrimary(context),
                ),
              ),
              const ThemeSwitch(),
              TombolCustom(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const TambahStokOwner()));
                },
                child: const Icon(Icons.assignment_add),
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
                return const Center(child: Text("No items found"));
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
                        'deskripsi': doc['deskripsi']
                      }))
                  .toList();

              return Column(
                children: [
                  FilterStokOwner(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: barang.length,
                      itemBuilder: (context, index) {
                        return barang[index].kategori ==
                                Provider.of<FilterStockProvider>(context)
                                    .selectedValue
                            ? Card(
                                elevation: 1.5,
                                surfaceTintColor:
                                    ShortcutHelper.warnaPrimary(context),
                                child: ListTile(
                                  leading: ClipOval(
                                    child: Image.asset(
                                      barang[index].foto,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const ClipOval(
                                          child: SizedBox(
                                            width: 50,
                                            height: 50,
                                            child: Placeholder(),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  trailing: Badge(
                                    backgroundColor:
                                        ShortcutHelper.warnaOnSurface(context),
                                    label: Text(
                                        barang[index].kategori.toUpperCase()),
                                  ),
                                  title: Text(barang[index].nama),
                                  subtitle:
                                      Text("Stok: ${barang[index].jumlah}"),
                                  onTap: () {
                                    UpdateStokOwner(barang[index])
                                        .showBottomSheet(context);
                                  },
                                ),
                              )
                            : SizedBox();
                      },
                    ),
                  ),
                ],
              );
            }));
  }
}
// FutureBuilder<List<BarangStok>>(
//         future: futureBarangStok,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//                 child: CircularProgressIndicator(
//               color: ShortcutHelper.warnaPrimary(context),
//             ));
//           } else if (snapshot.hasError) {
//             return Center(child: Text("Error: ${snapshot.error}"));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text("No items found"));
//           }
          // return Column(
          //   children: [
          //     FilterStokOwner(
          //       onSelectionChanged: (selectedValue) {
          //         filterStok(selectedValue);
          //       },
          //     ),
          //     Expanded(
          //       child: ListView.builder(
          //         itemCount: sampleBarang.length,
          //         itemBuilder: (context, index) {
          //           return Card(
          //             elevation: 1.5,
          //             surfaceTintColor: ShortcutHelper.warnaPrimary(context),
          //             child: ListTile(
          //               leading: ClipOval(
          //                 child: Image.asset(
          //                   sampleBarang[index].foto,
          //                   width: 50,
          //                   height: 50,
          //                   fit: BoxFit.cover,
          //                   errorBuilder: (context, error, stackTrace) {
          //                     return const ClipOval(
          //                       child: SizedBox(
          //                         width: 50,
          //                         height: 50,
          //                         child: Placeholder(),
          //                       ),
          //                     );
          //                   },
          //                 ),
          //               ),
          //               trailing: Badge(
          //                 backgroundColor:
          //                     ShortcutHelper.warnaOnSurface(context),
          //                 label:
          //                     Text(sampleBarang[index].kategori.toUpperCase()),
          //               ),
          //               title: Text(sampleBarang[index].nama),
          //               subtitle: Text("Stok: ${sampleBarang[index].jumlah}"),
          //               onTap: () {
          //                 UpdateStokOwner(sampleBarang[index], loadBarangData)
          //                     .showBottomSheet(context);
          //               },
          //             ),
          //           );
          //         },
          //       ),
          //     ),
          //   ],
          // );
      //   },
      // ),