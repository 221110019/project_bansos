import 'package:flutter/material.dart';
import 'package:project_bansos/helper/shortcut_helper.dart';
import 'package:project_bansos/models/barang_preorder.dart';
import 'package:intl/intl.dart';

Widget ListTilePesanan(BarangPreorder barangPreorder, context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10),
    child: SizedBox(
      height: 80,
      child: Card(
        surfaceTintColor: ShortcutHelper.warnaPrimary(context),
        // color: const Color.fromARGB(255, 84, 84, 84),
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Nama :  ${barangPreorder.namaBarang}",
                style: TextStyle(fontSize: 20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Jumlah  :  ${barangPreorder.jumlah}",
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                      'Waktu Pengambilan: ${DateFormat('dd-MM-yyyy - kk:mm').format(barangPreorder.waktuPengambilan.toDate())}')
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}
