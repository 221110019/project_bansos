import 'package:flutter/material.dart';
import 'package:project_bansos/components/theme_switch.dart';
import 'package:project_bansos/components/tombol_custom.dart';
import 'package:project_bansos/helper/shortcut_helper.dart';
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

class DashboardOwner extends StatelessWidget {
  const DashboardOwner({super.key});

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
          rekap(context),
          // Hanya muncul jika stok habis
          peringatan(context, 'Stok akan habis', Icons.warehouse_rounded),
          // hanya muncul jika ada barang expired
          peringatan(context, 'Ada barang yang akan expired',
              Icons.warning_amber_rounded),
          daftarStokHabis(),
          daftarStokExpired(),
        ],
      ),
    );
  }

  Container pengaturanUtama(BuildContext context) {
    AuthServices authServices = AuthServices();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const ThemeSwitch(),
          Text(ShortcutHelper.sekarang().toUpperCase()),
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
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            Text(
              jumlah.toString(),
              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
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
                isiCard(0, 'Jenis', 'Barang'),
                isiCard(0, 'Total', 'Pesanan'),
                isiCard(0, 'Akun', 'Pelanggan'),
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

  Widget daftarStokHabis() {
    return Container();
  }

  Widget daftarStokExpired() {
    return Container();
  }
}
