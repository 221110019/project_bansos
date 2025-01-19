import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_bansos/components/alt_gambar_error.dart';
import 'package:project_bansos/components/tombol_custom.dart';
import 'package:project_bansos/helper/shortcut_helper.dart';
import 'package:project_bansos/models/barang_stok.dart';
import 'package:project_bansos/services/firestore_services.dart';

class UpdateStokOwner {
  final BarangStok barang;
  final TextEditingController hargaController;
  UpdateStokOwner(this.barang, this.hargaController);
  FirestoreServices firestoreServices = FirestoreServices();

  void showBottomSheet(BuildContext context) => showModalBottomSheet(
        isDismissible: true,
        showDragHandle: true,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
            width: ShortcutHelper.lebarFull(context),
            height: ShortcutHelper.tinggiFull(context) * 0.95,
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'UPDATE STOK',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ShortcutHelper.warnaPrimary(context)),
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  child: Image.file(
                    File(barang.foto),
                    height: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const AltGambarError(
                        lebar: 100,
                        tinggi: 100,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Kategori : ${barang.kategori}',
                  textAlign: TextAlign.start,
                ),
                Text(
                  barang.nama.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w900),
                ),
                const Divider(),
                Text(
                  'Stok: ${barang.jumlah}',
                  style: const TextStyle(fontSize: 16),
                ),
                UpdateCounter(barang: barang, jenisBarang: 'stok'),
                const SizedBox(height: 20),
                Text(
                  'Yang di jual: ${barang.yangDijual}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                UpdateCounter(
                  barang: barang,
                  jenisBarang: 'yang dijual',
                ),
                const SizedBox(height: 20),
                SizedBox(
                    width: 100,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: hargaController,
                      decoration: InputDecoration(
                          hintText: "Rp.${barang.harga}",
                          border: const OutlineInputBorder()),
                    )),
                const SizedBox(height: 10),
                TombolCustom(
                  onPressed: () async {
                    if (hargaController.text.trim() != '') {
                      barang.harga = int.parse(hargaController.text.trim());
                    }
                    firestoreServices.updateItemStock(
                      barang,
                    );
                    print(barang.harga);
                    Navigator.pop(context);
                    ShortcutHelper.kataSistem(
                        context, 'Stok berhasil diperbarui');
                  },
                  child: const Text("SELESAI"),
                ),
                IconButton.outlined(
                  tooltip: 'Hapus barang',
                  onPressed: () async {
                    firestoreServices.deleteItemStock(barang.id);
                    Navigator.pop(context);
                    ShortcutHelper.kataSistem(
                        context, 'Barang berhasil dihapus');
                  },
                  icon: Icon(
                    Icons.delete,
                    color: ShortcutHelper.warnaPrimary(context),
                  ),
                ),
              ],
            ),
          );
        },
      );
}

class UpdateCounter extends StatefulWidget {
  final BarangStok barang;
  final String jenisBarang;
  const UpdateCounter(
      {super.key, required this.barang, required this.jenisBarang});

  @override
  State<UpdateCounter> createState() => _UpdateCounterState();
}

class _UpdateCounterState extends State<UpdateCounter> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TombolCustom(
          onPressed: () {
            if (widget.jenisBarang == 'stok') {
              widget.barang.kurangBarang();
            } else if (widget.jenisBarang == 'yang dijual') {
              widget.barang.kurangYangDijual();
            }
            setState(() {});
          },
          filled: false,
          child: const Icon(Icons.remove),
        ),
        widget.jenisBarang == 'stok'
            ? Text("${widget.barang.jumlah}")
            : Text("${widget.barang.yangDijual}"),
        TombolCustom(
            filled: false,
            onPressed: () {
              if (widget.jenisBarang == 'stok') {
                widget.barang.tambahBarang();
              } else if (widget.jenisBarang == 'yang dijual' &&
                  widget.barang.yangDijual < widget.barang.jumlah) {
                widget.barang.tambahYangDijual();
              }
              setState(() {});
            },
            child: const Icon(Icons.add)),
      ],
    );
  }
}
