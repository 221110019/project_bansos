import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_bansos/components/language_button.dart';
import 'package:project_bansos/components/theme_switch.dart';
import 'package:project_bansos/components/tombol_custom.dart';
import 'package:project_bansos/helper/cakap_helper.dart';
import 'package:project_bansos/helper/exp_stok_helper.dart';
import 'package:project_bansos/helper/shortcut_helper.dart';
import 'package:project_bansos/services/auth_services.dart';
import 'package:provider/provider.dart';
import 'package:project_bansos/provider/owner_bottom_nav_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Owner Dashboard',
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
          "Owner Dashboard".toUpperCase(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: ShortcutHelper.warnaPrimary(context),
          ),
        ),
      ),
      body: Column(
        children: [
          Text(
            IndomieHelper.sekarang().toUpperCase(),
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          Divider(color: ShortcutHelper.warnaOnSurface(context)),
          pengaturanUtama(context),
          Divider(color: ShortcutHelper.warnaOnSurface(context)),
          rekap(context),
          context.read<OwnerMetaProvider>().jumlahStHabis > 0
              ? peringatan(context, CakapHelper.tulisan(context)!.o_dash_1,
                  Icons.warehouse_rounded)
              : const SizedBox.shrink(),
          context.read<OwnerMetaProvider>().jumlahExp > 0
              ? peringatan(context, CakapHelper.tulisan(context)!.o_dash_2,
                  Icons.warning_amber_rounded)
              : const SizedBox.shrink(),
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
          const LanguageButton(),
          TombolCustom(
              onPressed: () {
                authServices.logoutUser();
                ShortcutHelper.notifWoe(context).createLogoutNotification();
              },
              child: Text(CakapHelper.tulisan(context)!.o_dash_3))
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
                          return isiCard(
                              0,
                              CakapHelper.tulisan(context)!.o_dash_6,
                              CakapHelper.tulisan(context)!.o_dash_4);
                        }
                        if (snapshot.hasError || !snapshot.hasData) {
                          return isiCard(
                              0,
                              CakapHelper.tulisan(context)!.o_dash_6,
                              CakapHelper.tulisan(context)!.o_dash_4);
                        }
                        return isiCard(
                            snapshot.data!.docs.length,
                            CakapHelper.tulisan(context)!.o_dash_6,
                            CakapHelper.tulisan(context)!.o_dash_4);
                      },
                    ),
                    isiCard(
                        context.read<OwnerMetaProvider>().jumlahExp,
                        CakapHelper.tulisan(context)!.o_dash_4,
                        CakapHelper.tulisan(context)!.o_dash_5),
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
                          return isiCard(0, 'Total',
                              CakapHelper.tulisan(context)!.o_dash_7);
                        }
                        if (snapshot.hasError || !snapshot.hasData) {
                          return isiCard(0, 'Total',
                              CakapHelper.tulisan(context)!.o_dash_7);
                        }
                        return isiCard(snapshot.data!.docs.length, 'Total',
                            CakapHelper.tulisan(context)!.o_dash_7);
                      },
                    ),
                    isiCard(
                        context.read<OwnerMetaProvider>().jumlahStHabis,
                        CakapHelper.tulisan(context)!.o_home_1,
                        CakapHelper.tulisan(context)!.o_dash_8)
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
      padding: const EdgeInsets.symmetric(vertical: 8),
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
