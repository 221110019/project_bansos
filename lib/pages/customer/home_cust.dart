import 'package:flutter/material.dart';
import 'package:project_bansos/helper/cakap_helper.dart';
import 'package:project_bansos/helper/shortcut_helper.dart';
import 'package:project_bansos/pages/customer/barang.dart';
import 'package:project_bansos/pages/customer/pesanan.dart';
import 'package:project_bansos/pages/customer/profil.dart';

class HomeCust extends StatefulWidget {
  const HomeCust({super.key});

  @override
  State<HomeCust> createState() => _HomeCustState();
}

class _HomeCustState extends State<HomeCust> {
  int bottomNavIndex = 0;
  final List _children = [
    Barang(searchButton: () {}),
    const Pesanan(),
    const Profil()
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: _children[bottomNavIndex],
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent),
          child: BottomNavigationBar(
              currentIndex: bottomNavIndex,
              onTap: (value) {
                setState(() {
                  bottomNavIndex = value;
                });
              },
              fixedColor: ShortcutHelper.warnaPrimary(context),
              items: [
                BottomNavigationBarItem(
                    icon: const Icon(Icons.grid_view),
                    label: CakapHelper.tulisan(context)!.cust_barang_1),
                BottomNavigationBarItem(
                    icon: const Icon(Icons.receipt_long),
                    label: CakapHelper.tulisan(context)!.o_home_2),
                BottomNavigationBarItem(
                    icon: const Icon(Icons.person),
                    label: CakapHelper.tulisan(context)!.cust_barang_1)
              ]),
        ),
      ),
    );
  }
}
