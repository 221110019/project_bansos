import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_bansos/components/alt_gambar_error.dart';
import 'package:project_bansos/components/tombol_custom.dart';
import 'package:project_bansos/helper/cakap_helper.dart';
import 'package:project_bansos/helper/shortcut_helper.dart';
import 'package:project_bansos/models/barang_stok.dart';
import 'package:project_bansos/services/auth_services.dart';
import 'package:project_bansos/services/datetime_services.dart';
import 'package:project_bansos/services/firestore_services.dart';

class DetailBarang extends StatefulWidget {
  final BarangStok barangStok;
  const DetailBarang({super.key, required this.barangStok});

  @override
  State<DetailBarang> createState() => _DetailBarangState();
}

class _DetailBarangState extends State<DetailBarang> {
  FirestoreServices firestoreServices = FirestoreServices();
  AuthServices authServices = AuthServices();
  DatetimeServices datetimeServices = DatetimeServices();
  DateTime? waktuPengambilan = null;
  int itemPreorder = 0;
  void addPreorder() {
    setState(() {
      if (itemPreorder < widget.barangStok.yangDijual) {
        itemPreorder += 1;
      }
    });
  }

  void removePreorder() {
    setState(() {
      if (itemPreorder > 0) {
        itemPreorder -= 1;
      }
    });
  }

  void preorder() {
    if (itemPreorder != 0 && waktuPengambilan != null) {
      setState(() {
        firestoreServices.createPreorder({
          'namaBarang': widget.barangStok.nama,
          'idPembeli': authServices.auth.currentUser!.uid,
          'kategori': widget.barangStok.kategori,
          'foto': widget.barangStok.foto,
          'jumlah': itemPreorder,
          'waktuPengambilan': waktuPengambilan
        }, widget.barangStok, authServices.auth.currentUser!.uid);
      });
      Navigator.of(context).pop();
    }
  }

  void setWaktuPengambilan() async {
    DateTime? selectedDate = await datetimeServices.selectDate(context);
    TimeOfDay? selectedTime = await datetimeServices.selectTime(context);
    if (selectedDate != null && selectedTime != null) {
      setState(() {
        waktuPengambilan = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );
      });
    }
    print(waktuPengambilan);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CakapHelper.tulisan(context)!.cust_detail_1),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  child: Image(
                    fit: BoxFit.cover,
                    image: FileImage(
                      File(widget.barangStok.foto),
                    ),
                    errorBuilder: (context, error, stackTrace) {
                      return const AltGambarError(lebar: 50, tinggi: 50);
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.barangStok.nama,
                      style: const TextStyle(
                          fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${CakapHelper.tulisan(context)!.list_tile_pesanan_2} : ${widget.barangStok.yangDijual.toString()}",
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                        '${CakapHelper.tulisan(context)!.o_add_stok_4}: ${widget.barangStok.deskripsi}'),
                    Row(
                      children: [
                        Text(
                            '${CakapHelper.tulisan(context)!.list_tile_pesanan_3}: '),
                        waktuPengambilan == null
                            ? Text(CakapHelper.tulisan(context)!.cust_detail_2)
                            : Text(DateFormat('HH:mm, dd MMMM yyyy')
                                .format(waktuPengambilan!)),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  ShortcutHelper.warnaOnSurface(context),
                              minimumSize: const Size(0, 10),
                              shape: const BeveledRectangleBorder(),
                            ),
                            onPressed: setWaktuPengambilan,
                            child: Text(
                                CakapHelper.tulisan(context)!.cust_detail_3,
                                style: TextStyle(
                                  color: ShortcutHelper.warnaSurface(context),
                                )))
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: removePreorder,
                        icon: const Icon(
                          Icons.remove,
                          size: 40,
                        )),
                    Text(
                      itemPreorder.toString(),
                      style: const TextStyle(fontSize: 30),
                    ),
                    IconButton(
                        onPressed: addPreorder,
                        icon: const Icon(
                          Icons.add,
                          size: 40,
                        ))
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: TombolCustom(
                      onPressed: preorder,
                      child: const Text(
                        'Preorder',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
