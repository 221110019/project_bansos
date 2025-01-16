import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_bansos/components/tombol_custom.dart';
import 'package:project_bansos/helper/shortcut_helper.dart';
import 'package:project_bansos/services/datetime_services.dart';
import 'package:project_bansos/services/firestore_services.dart';

class TambahStokOwner extends StatefulWidget {
  const TambahStokOwner({super.key});

  @override
  State<TambahStokOwner> createState() => _TambahStokOwnerState();
}

class _TambahStokOwnerState extends State<TambahStokOwner> {
  FirestoreServices firestoreServices = FirestoreServices();
  DatetimeServices datetimeServices = DatetimeServices();
  TextEditingController namaController = TextEditingController();
  TextEditingController fotoController = TextEditingController();
  TextEditingController jumlahController = TextEditingController();
  TextEditingController kadarluasaController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();
  String selectedKategori = 'Kue';
  late DateTime? picked;
  final List<String> kategoriOptions = ['Kue', 'Alat', 'Acak'];

  void saveBarang() {
    if (namaController.text.isNotEmpty && jumlahController.text.isNotEmpty) {
      firestoreServices.createItemStock({
        'nama': namaController.text,
        'foto': fotoController.text,
        'jumlah': int.parse(jumlahController.text),
        'yangDijual': 0,
        'kategori': selectedKategori,
        'deskripsi': deskripsiController.text,
        'kadarluasa': Timestamp.fromDate(picked!),
        'harga': 0
      });
      ShortcutHelper.kataSistem(context, 'Barang berhasil ditambahkan');
      Navigator.of(context).pop();
    } else {
      ShortcutHelper.kataSistem(context, 'Mohon isi semuanya');
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
                controller: fotoController,
                decoration: const InputDecoration(
                    labelText: 'Foto', border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: namaController,
                decoration: const InputDecoration(
                    labelText: 'Nama Barang', border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: jumlahController,
                decoration: const InputDecoration(
                    labelText: 'Jumlah Barang', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                readOnly: true,
                onTap: () async {
                  picked = await datetimeServices.selectDate(context);

                  setState(() {
                    if (picked != null) {
                      kadarluasaController.text =
                          DateFormat('dd MMMM yyyy').format(picked!).toString();
                    }
                  });
                },
                controller: kadarluasaController,
                decoration: const InputDecoration(
                    hintText: 'Kadarluasa',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white))),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: deskripsiController,
                decoration: const InputDecoration(
                    labelText: 'Deskripsi', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 10),
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
                hint: const Text('Pilih Kategori'),
              ),
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
