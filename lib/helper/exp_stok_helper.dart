import 'package:intl/intl.dart';

class IndomieHelper {
  static String sekarang() {
    final now = DateTime.now();
    final formatTanggal = DateFormat('dd MMMM yyyy', Intl.defaultLocale);
    return formatTanggal.format(now);
  }

  static String waktuPengambilan(DateTime waktuPengambilan) {
    DateTime now = DateTime.now();
    DateTime target = waktuPengambilan;
    Duration difference = target.difference(now);

    String remainingTime =
        '${difference.inDays} hari, ${difference.inHours % 24} jam, ${difference.inMinutes % 60} menit';
    return remainingTime;
  }

  static String waktuExpired(DateTime waktuKadarluasa) {
    DateTime now = DateTime.now();
    Duration difference = waktuKadarluasa.difference(now);

    if (difference.isNegative) {
      return "! Sudah Kedaluwarsa !".toUpperCase();
    }

    String remainingTime =
        '${difference.inDays} hari, ${difference.inHours % 24} jam, ${difference.inMinutes % 60} menit';

    return remainingTime;
  }

  // static bool cekSisaStok(List<BarangPreorder> barang) {
  //   return barang.any((item) => item.jumlah <= 5);
  // }

  // static bool cekBarangExpired(List<BarangPreorder> barang) {
  //   DateTime now = DateTime.now();
  //   return barang.any((item) => item.waktuPengambilan.toDate().isBefore(now));
  // }
}
