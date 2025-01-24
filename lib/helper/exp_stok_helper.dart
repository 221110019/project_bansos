import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_bansos/helper/cakap_helper.dart';

class IndomieHelper {
  static String sekarang() {
    final now = DateTime.now();
    final formatTanggal = DateFormat('dd MMMM yyyy', Intl.defaultLocale);
    return formatTanggal.format(now);
  }

  static String waktuPengambilan(context, DateTime waktuPengambilan) {
    DateTime now = DateTime.now();
    DateTime target = waktuPengambilan;
    Duration difference = target.difference(now);

    String remainingTime(BuildContext context) {
      return '${difference.inDays} ${CakapHelper.tulisan(context)!.h_exp_1}, ${difference.inHours % 24} ${CakapHelper.tulisan(context)!.h_exp_2}, ${difference.inMinutes % 60} ${CakapHelper.tulisan(context)!.h_exp_3}';
    }

    return remainingTime(context);
  }

  static String waktuExpired(BuildContext context, DateTime waktuKadarluasa) {
    DateTime now = DateTime.now();
    Duration difference = waktuKadarluasa.difference(now);

    if (difference.isNegative) {
      return "! ${CakapHelper.tulisan(context)!.h_exp_4} !".toUpperCase();
    }

    String remainingTime(BuildContext context) {
      return '${difference.inDays} ${CakapHelper.tulisan(context)!.h_exp_1}, ${difference.inHours % 24} ${CakapHelper.tulisan(context)!.h_exp_2}, ${difference.inMinutes % 60} ${CakapHelper.tulisan(context)!.h_exp_3}';
    }

    return remainingTime(context);
  }

  // static bool cekSisaStok(List<BarangPreorder> barang) {
  //   return barang.any((item) => item.jumlah <= 5);
  // }

  // static bool cekBarangExpired(List<BarangPreorder> barang) {
  //   DateTime now = DateTime.now();
  //   return barang.any((item) => item.waktuPengambilan.toDate().isBefore(now));
  // }
}
