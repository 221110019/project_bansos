import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_bansos/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class ShortcutHelper {
  static Color warnaSurface(BuildContext context) {
    return Theme.of(context).colorScheme.surface; //hitam:putih
  }

  static Color warnaOnSurface(BuildContext context) {
    return Theme.of(context).colorScheme.onSurface; //putih:hitam
  }

  static Color warnaPrimary(BuildContext context) {
    return Theme.of(context).colorScheme.primary; //merah:merah
  }

  static Color warnaOnPrimary(BuildContext context) {
    return Theme.of(context).colorScheme.onPrimary; //hitam:putih
  }

  static ThemeProvider temaTerang(BuildContext context) {
    return Provider.of<ThemeProvider>(context);
  }

  static double lebarFull(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double tinggiFull(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static Future<dynamic> pushKe(BuildContext context, Widget nextHalaman) {
    return Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => nextHalaman,
    ));
  }

  static String rupiahkan(int amount) {
    final formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return formatter.format(amount);
  }

  static String sekarang() {
    final now = DateTime.now();
    final formatTanggal = DateFormat('dd MMMM yyyy', Intl.defaultLocale);
    return formatTanggal.format(now);
  }

  static ScaffoldFeatureController kataSistem(
      BuildContext context, String pesan) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        dismissDirection: DismissDirection.horizontal,
        showCloseIcon: true,
        clipBehavior: Clip.antiAlias,
        content: Text(pesan),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
