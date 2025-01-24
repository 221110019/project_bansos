import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project_bansos/components/alt_gambar_error.dart';
import 'package:project_bansos/helper/cakap_helper.dart';
import 'package:project_bansos/helper/shortcut_helper.dart';
import 'package:project_bansos/models/barang_stok.dart';

class ListTileCust extends StatelessWidget {
  final BarangStok barang;
  final GestureTapCallback ontap;
  const ListTileCust({super.key, required this.barang, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.45,
      surfaceTintColor: ShortcutHelper.warnaPrimary(context),
      child: ListTile(
        leading: Badge(
          alignment: Alignment.topLeft,
          backgroundColor: ShortcutHelper.warnaPrimary(context),
          label: Text(barang.kategori.toUpperCase()),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.file(
              File(barang.foto),
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const AltGambarError(lebar: 50, tinggi: 50);
              },
            ),
          ),
        ),
        title: Text(
          barang.nama.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.w900),
        ),
        subtitle: Text(
            "${barang.yangDijual} ${CakapHelper.tulisan(context)!.o_home_1.toLowerCase()}"),
        onTap: ontap,
      ),
    );
  }
}
