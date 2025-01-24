import 'package:flutter/material.dart';
import 'package:project_bansos/helper/cakap_helper.dart';
import 'package:project_bansos/helper/exp_stok_helper.dart';
import 'package:project_bansos/helper/shortcut_helper.dart';
import 'package:project_bansos/models/barang_preorder.dart';

Padding listTilePesanan(BarangPreorder barangPreorder, context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: SizedBox(
      height: 80,
      width: ShortcutHelper.lebarFull(context),
      child: Card(
        surfaceTintColor: ShortcutHelper.warnaPrimary(context),
        child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                          CakapHelper.tulisan(context)!.list_tile_pesanan_1,
                          style: const TextStyle(fontSize: 20)),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        ': ${barangPreorder.namaBarang}'.toUpperCase(),
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                          CakapHelper.tulisan(context)!.list_tile_pesanan_2),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(': ${barangPreorder.jumlah}'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        CakapHelper.tulisan(context)!.list_tile_pesanan_3,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        ': ${IndomieHelper.waktuPengambilan(context, barangPreorder.waktuPengambilan.toDate())}',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    ),
  );
}
