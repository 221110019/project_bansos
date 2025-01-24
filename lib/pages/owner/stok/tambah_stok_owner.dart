import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project_bansos/components/tombol_custom.dart';
import 'package:project_bansos/helper/cakap_helper.dart';
import 'package:project_bansos/provider/theme_provider.dart';
import 'package:project_bansos/services/datetime_services.dart';
import 'package:project_bansos/services/firestore_services.dart';
import 'package:project_bansos/services/imagepicker_services.dart';
import 'package:provider/provider.dart';

class TambahStokOwner extends StatefulWidget {
  const TambahStokOwner({super.key});

  @override
  State<TambahStokOwner> createState() => _TambahStokOwnerState();
}

class _TambahStokOwnerState extends State<TambahStokOwner> {
  ImagepickerServices imagepickerServices = ImagepickerServices();
  File? imageFile;
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

  void saveBarang() async {
    if (namaController.text.isNotEmpty &&
        jumlahController.text.isNotEmpty &&
        imageFile?.path != null) {
      firestoreServices.createItemStock({
        'nama': namaController.text,
        'foto': imageFile!.path,
        'jumlah': int.parse(jumlahController.text),
        'yangDijual': 0,
        'kategori': selectedKategori,
        'deskripsi': deskripsiController.text,
        'kadarluasa': picked != null ? Timestamp.fromDate(picked!) : null,
        'harga': 0
      });

      print('Item saved successfully');
    } else {
      print('Please fill in all required fields');
    }
    Navigator.of(context).pop();
  }

  void _requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (status.isGranted) {
      print('kamera sudah diizinkan');
      addFoto();
    } else if (status.isDenied) {
      await Permission.camera.request();
      print('kamera tidak diizinkan');
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
      print('kamera tidak diizinkan secara permanen');
    }
  }

  void addFoto() async {
    final pickedImage = await imagepickerServices.pickImage();
    setState(() {
      imageFile = pickedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(CakapHelper.tulisan(context)!.o_add_stok_1)),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: _requestCameraPermission,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(
                          color:
                              Provider.of<ThemeProvider>(context, listen: false)
                                      .terang
                                  ? Colors.black
                                  : Colors.white)),
                  height: 200,
                  child: imageFile == null
                      ? const Center(
                          child: Icon(Icons.add),
                        )
                      : Image.file(
                          imageFile!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: namaController,
                decoration: InputDecoration(
                    labelText: CakapHelper.tulisan(context)!.o_add_stok_2,
                    border: const OutlineInputBorder()),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: jumlahController,
                decoration: InputDecoration(
                    labelText: CakapHelper.tulisan(context)!.o_add_stok_3,
                    border: const OutlineInputBorder()),
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
                decoration: InputDecoration(
                    hintText: CakapHelper.tulisan(context)!.o_dash_5,
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white))),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: deskripsiController,
                decoration: InputDecoration(
                    labelText: CakapHelper.tulisan(context)!.o_add_stok_4,
                    border: const OutlineInputBorder()),
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
                hint: Text(CakapHelper.tulisan(context)!.o_add_stok_5),
              ),
              TombolCustom(
                onPressed: saveBarang,
                child: Text(CakapHelper.tulisan(context)!.o_add_stok_6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
