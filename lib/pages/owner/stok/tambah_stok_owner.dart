import 'package:flutter/material.dart';
import 'package:project_bansos/components/tombol_custom.dart';

class TambahStokOwner extends StatelessWidget {
  const TambahStokOwner({super.key});

  // void addSampleData() async {
  //   await BarangStokDB().insertSampleData();
  //   print("Sample data inserted.");
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: TombolCustom(
            onPressed: () {},
            child: const Text('tes tambah data ke sql'),
          ),
        ),
      ),
    );
  }
}
