import 'package:flutter/material.dart';
import 'package:project_bansos/components/theme_switch.dart';
import 'package:project_bansos/components/tombol_custom.dart';
import 'package:project_bansos/helper/shortcut_helper.dart';
import 'package:project_bansos/models/barang_stok.dart';
import 'package:project_bansos/pages/owner/stok/tambah_stok_owner.dart';
import 'package:project_bansos/pages/owner/stok/update_stok_owner.dart';

class StokOwner extends StatelessWidget {
  const StokOwner({super.key});

  @override
  Widget build(BuildContext context) {
    List<BarangStok> sampleBarang = [
      BarangStok(
        id: 1,
        nama: "Kue Coklat",
        foto: "assets/pictures/semprit-susu.jpg",
        jumlah: 10,
        kategori: "Kue",
        deskripsi: "Kue coklat lezat dengan tekstur yang lembut.",
      ),
      BarangStok(
        id: 2,
        nama: "Kue Keju",
        foto: "assets/pictures/semprit-susu.jpg",
        jumlah: 5,
        kategori: "Kue",
        deskripsi: "Kue keju dengan rasa gurih dan renyah.",
      ),
      BarangStok(
        id: 3,
        nama: "Piring Plastik",
        foto: "assets/pictures/semprit-susu.jpg",
        jumlah: 20,
        kategori: "Alat",
        deskripsi: "Piring plastik yang cocok untuk pesta dan piknik.",
      ),
      BarangStok(
        id: 4,
        nama: "Pisau Dapur",
        foto: "assets/pictures/semprit-susu.jpg",
        jumlah: 8,
        kategori: "Alat",
        deskripsi: "Pisau dapur tajam untuk memotong bahan masakan.",
      ),
      BarangStok(
        id: 5,
        nama: "Mainan Acak",
        foto: "assets/pictures/semprit-susu.jpg",
        jumlah: 15,
        kategori: "Acak",
        deskripsi: "Mainan acak yang bisa digunakan sebagai hadiah.",
      ),
      BarangStok(
        id: 6,
        nama: "Hiasan Dinding",
        foto: "assets/pictures/semprit-susu.jpg",
        jumlah: 7,
        kategori: "Acak",
        deskripsi: "Hiasan dinding untuk mempercantik ruangan.",
      ),
      BarangStok(
        id: 7,
        nama: "Kue Nastar",
        foto: "assets/pictures/semprit-susu.jpg",
        jumlah: 12,
        kategori: "Kue",
        deskripsi: "Kue nastar dengan isian nanas yang manis.",
      ),
      BarangStok(
        id: 8,
        nama: "Sendok Kayu",
        foto: "assets/pictures/semprit-susu.jpg",
        jumlah: 6,
        kategori: "Alat",
        deskripsi: "Sendok kayu yang cocok untuk memasak.",
      ),
      BarangStok(
        id: 9,
        nama: "Boneka Acak",
        foto: "assets/pictures/semprit-susu.jpg",
        jumlah: 3,
        kategori: "Acak",
        deskripsi: "Boneka lucu yang bisa dijadikan koleksi.",
      ),
      BarangStok(
        id: 10,
        nama: "Kue Semprit",
        foto: "assets/pictures/semprit-susu.jpg",
        jumlah: 18,
        kategori: "Kue",
        deskripsi: "Kue semprit susu dengan bentuk unik dan rasa enak.",
      ),
    ];

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 60, 10, 10),
        child: ListView.builder(
          itemCount: sampleBarang.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(2)),
                  child: Image.asset(sampleBarang[index].foto),
                ),
                title: Text("Nama: ${sampleBarang[index].nama}"),
                subtitle: Text("Stok: ${sampleBarang[index].jumlah}"),
                trailing: TombolCustom(
                  onPressed: () {
                    UpdateStokOwner(sampleBarang[index])
                        .showBottomSheet(context);
                  },
                  filled: false,
                  child: const Icon(Icons.edit),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("STOK BARANG",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ShortcutHelper.warnaPrimary(context),
                )),
            const ThemeSwitch(),
            TombolCustom(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const TambahStokOwner(),
                  ));
                },
                child: const Icon(Icons.assignment_add)),
          ],
        ),
      ),
    );
  }
}
