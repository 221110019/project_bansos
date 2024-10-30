import 'package:flutter/material.dart';
import 'package:project_bansos/helper/shortcut_helper.dart';
import 'package:project_bansos/pages/owner/dashboard_owner.dart';
import 'package:project_bansos/pages/owner/pesanan_owner.dart';
import 'package:project_bansos/pages/owner/stok/stok_owner.dart';
import 'package:project_bansos/provider/owner_bottom_nav_provider.dart';
import 'package:provider/provider.dart';

class HomeOwner extends StatelessWidget {
  const HomeOwner({super.key});

  static const List<Widget> tabs = [
    DashboardOwner(),
    StokOwner(),
    PesananOwner()
  ];

  @override
  Widget build(BuildContext context) {
    final ownerBottomNavProvider =
        Provider.of<OwnerBottomNavProvider>(context, listen: true);
    return Scaffold(
        body: Consumer<OwnerBottomNavProvider>(
          builder: (context, provider, child) {
            return tabs[provider.currentIndex];
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: ownerBottomNavProvider.currentIndex,
          onTap: (index) => ownerBottomNavProvider.setIndex(index),
          selectedItemColor: ShortcutHelper.warnaPrimary(context),
          unselectedItemColor: ShortcutHelper.warnaOnSurface(context),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.dashboard), label: 'Dashboard'),
            BottomNavigationBarItem(
                icon: Icon(Icons.assignment), label: 'Stok'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_pin_circle), label: 'Pesanan'),
          ],
        ));
  }
}