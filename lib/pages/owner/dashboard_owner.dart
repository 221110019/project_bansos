import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_bansos/components/theme_switch.dart';
import 'package:project_bansos/components/tombol_custom.dart';
import 'package:project_bansos/helper/exp_stok_helper.dart';
import 'package:project_bansos/helper/shortcut_helper.dart';
import 'package:project_bansos/models/barang_stok.dart';
import 'package:project_bansos/services/auth_services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Dashboard Owner',
      home: DashboardOwner(),
    );
  }
}

class DashboardOwner extends StatefulWidget {
  const DashboardOwner({super.key});

  @override
  State<DashboardOwner> createState() => _DashboardOwnerState();
}

class _DashboardOwnerState extends State<DashboardOwner> {
  bool warning1 = false;
  bool warning2 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dashboard Owner".toUpperCase(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: ShortcutHelper.warnaPrimary(context),
          ),
        ),
      ),
      body: Column(
        children: [
          Divider(color: ShortcutHelper.warnaOnSurface(context)),
          pengaturanUtama(context),
          Divider(color: ShortcutHelper.warnaOnSurface(context)),
          warning1
              ? peringatan(
                  context, 'Ada stok yang/akan habis', Icons.warehouse_rounded)
              : const SizedBox.shrink(),
          warning2
              ? peringatan(context, 'Ada barang yang/akan expired',
                  Icons.warning_amber_rounded)
              : const SizedBox.shrink(),
          rekap(context),
        ],
      ),
    );
  }

  Container pengaturanUtama(BuildContext context) {
    AuthServices authServices = AuthServices();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const ThemeSwitch(),
              Text(IndomieHelper.sekarang().toUpperCase()),
            ],
          ),
          TombolCustom(
              onPressed: () {
                authServices.logoutUser();
                ShortcutHelper.kataSistem(context, 'Berhasil keluar');
              },
              child: const Text('Logout'))
        ],
      ),
    );
  }

  Container rekap(BuildContext context) {
    Container isiCard(int jumlah, String nama1, String nama2) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Column(
          children: [
            Text(
              jumlah.toString(),
              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 50),
            ),
            Text(
              nama1.toUpperCase(),
              style: const TextStyle(
                fontSize: 10,
              ),
            ),
            Text(
              nama2.toUpperCase(),
              style: const TextStyle(fontSize: 10),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Card(
            shadowColor: ShortcutHelper.warnaOnSurface(context),
            elevation: 5,
            surfaceTintColor: ShortcutHelper.warnaPrimary(context),
            borderOnForeground: true,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('stock_barang')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return isiCard(0, 'Jenis', 'Barang');
                        }
                        if (snapshot.hasError || !snapshot.hasData) {
                          return isiCard(0, 'Jenis', 'Barang');
                        }
                        List<BarangStok> barang =
                            snapshot.data!.docs.map((doc) {
                          final data = doc.data();
                          return BarangStok.fromMap({
                            'id': doc.id,
                            'nama': data['nama'],
                            'kategori': data['kategori'],
                            'foto': data['foto'],
                            'jumlah': data['jumlah'],
                            'yangDijual': data['yangDijual'],
                            'deskripsi': data['deskripsi'],
                            'harga': data['harga'],
                            'kadarluasa': data['kadarluasa'],
                          });
                        }).toList();
                        int expiredCount = barang.where((item) {
                          return BarangStok.cekBarangExpired([item]);
                        }).length;
                        warning1 = true;
                        return Column(
                          children: [
                            isiCard(barang.length, 'Jenis', 'Barang'),
                            isiCard(expiredCount, 'Barang', 'Expired'),
                          ],
                        );
                      },
                    ),
                  ],
                ),
                Column(
                  children: [
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('preorder')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return isiCard(0, 'Total', 'Pesanan');
                        }
                        if (snapshot.hasError || !snapshot.hasData) {
                          return isiCard(0, 'Total', 'Pesanan');
                        }
                        return isiCard(
                            snapshot.data!.docs.length, 'Total', 'Pesanan');
                      },
                    ),
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('stock_barang')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return isiCard(0, 'Stok', 'Habis');
                        }
                        if (snapshot.hasError || !snapshot.hasData) {
                          return isiCard(0, 'Stok', 'Habis');
                        }
                        List<BarangStok> barang =
                            snapshot.data!.docs.map((doc) {
                          final data = doc.data();
                          return BarangStok.fromMap({
                            'id': doc.id,
                            'nama': data['nama'],
                            'kategori': data['kategori'],
                            'foto': data['foto'],
                            'jumlah': data['jumlah'],
                            'yangDijual': data['yangDijual'],
                            'deskripsi': data['deskripsi'],
                            'harga': data['harga'],
                            'kadarluasa': data['kadarluasa'],
                          });
                        }).toList();
                        int lowStockCount = barang
                            .where((item) => BarangStok.cekSisaStok([item]))
                            .length;
                        warning2 = true;
                        return isiCard(lowStockCount, 'Stok', 'Sisa Sedikit');
                      },
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container peringatan(BuildContext context, String isi, IconData ikon) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.only(top: 8),
      width: ShortcutHelper.lebarFull(context) * 0.85,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.symmetric(
            horizontal: BorderSide(
              strokeAlign: BorderSide.strokeAlignCenter,
              color: ShortcutHelper.warnaPrimary(context),
            ),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(ikon, color: ShortcutHelper.warnaPrimary(context)),
          const SizedBox(width: 8.0),
          Text(
            isi,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: ShortcutHelper.warnaOnSurface(context)),
          ),
          const SizedBox(width: 8.0),
          Icon(ikon, color: ShortcutHelper.warnaPrimary(context)),
        ],
      ),
    );
  }
}
