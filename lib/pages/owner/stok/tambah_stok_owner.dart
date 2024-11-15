import 'package:flutter/material.dart';
import 'package:project_bansos/components/tombol_custom.dart';
import 'package:project_bansos/database/database_stok.dart';

class TambahStokOwner extends StatelessWidget {
  const TambahStokOwner({super.key});

  void addSampleData() async {
    await BarangStokDB().insertSampleData();
    print("Sample data inserted.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: TombolCustom(
            // onPressed: () {},
            onPressed: addSampleData,
            child: const Text('tes tambah data ke sql'),
          ),
        ),
      ),
    );
  }
}
