import 'package:flutter/material.dart';
import 'package:project_bansos/models/barang_preorder.dart';

Widget ListTilePesanan(BarangPreorder barangPreorder) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10),
    child: SizedBox(
      // height: 50,
      child: Card(
        color: Colors.grey,
        shape: BeveledRectangleBorder(),
        child: Column(
          children: [Text('Nama')],
        ),
      ),
    ),
  );
}
