import 'package:flutter/material.dart';
import 'package:project_bansos/components/tombol_custom.dart';
import 'package:project_bansos/database/database_stok.dart';
import 'package:project_bansos/models/barang_stok.dart';
import 'package:project_bansos/services/firestore_services.dart';

class TambahStokOwner extends StatefulWidget {
  const TambahStokOwner({super.key});

  @override
  State<TambahStokOwner> createState() => _TambahStokOwnerState();
}

class _TambahStokOwnerState extends State<TambahStokOwner> {
  // void addSampleData() async {
  //   await BarangStokDB().insertSampleData();
  //   print("Sample data inserted.");
  // }
  FirestoreServices firestoreServices = FirestoreServices();
  TextEditingController namaController = TextEditingController();
  TextEditingController fotoController = TextEditingController();
  TextEditingController jumlahController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();
  String selectedKategori = 'Kue';

  final List<String> kategoriOptions = ['Kue', 'Alat', 'Acak'];

  void saveBarang() {
    if (namaController.text.isNotEmpty && jumlahController.text.isNotEmpty) {
      // BarangStok barang = BarangStok(
      // nama: namaController.text,
      // foto: fotoController.text,
      // jumlah: int.parse(jumlahController.text),
      // kategori: selectedKategori,
      // deskripsi: deskripsiController.text,
      // );
      firestoreServices.createItem({
        'nama': namaController.text,
        'foto': fotoController.text,
        'jumlah': int.parse(jumlahController.text),
        'kategori': selectedKategori,
        'deskripsi': deskripsiController.text,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Barang berhasil ditambahkan')),
      );
      Navigator.of(context).pop();
      // BarangStokDB().insert(barang).then((brgId) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //         content: Text('Barang berhasil ditambahkan dengan ID: $brgId')),
      //   );
      // });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mohon isi semua field!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Barang')),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: namaController,
                decoration: const InputDecoration(labelText: 'Nama Barang'),
              ),
              TextField(
                controller: fotoController,
                decoration: const InputDecoration(labelText: 'Foto'),
              ),
              TextField(
                controller: jumlahController,
                decoration: const InputDecoration(labelText: 'Jumlah Barang'),
                keyboardType: TextInputType.number,
              ),
              DropdownButton<String>(
                value: selectedKategori,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedKategori = newValue!;
                  });
                },
                items: kategoriOptions
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                hint: Text('Pilih Kategori'),
              ),
              TextField(
                controller: deskripsiController,
                decoration: const InputDecoration(labelText: 'Deskripsi'),
              ),
              const SizedBox(height: 20),
              TombolCustom(
                onPressed: saveBarang,
                child: const Text('Simpan Barang'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
