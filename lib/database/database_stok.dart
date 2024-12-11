// import 'package:project_bansos/database/database_service.dart';
// import 'package:project_bansos/models/barang_stok.dart';
// import 'package:sqflite/sqflite.dart';

// class BarangStokDB {
//   String tableName = "stoksbarang";
//   String columnNama = "nama";
//   String columnFoto = "foto";
//   String columnJumlah = "jumlah";
//   String columnKategori = "kategori";
//   String columnDeskripsi = "deskripsi";
//   DatabaseServices databaseServices = DatabaseServices();

//   Future<List<BarangStok>> read({String? selectedValue}) async {
//     Database db = await databaseServices.getDatabase();

//     // If a category is selected, filter the results based on the selected category
//     List<Map<String, dynamic>> data;
//     if (selectedValue != null && selectedValue != 'All') {
//       data = await db.query(
//         tableName,
//         where: '$columnKategori = ?',
//         whereArgs: [selectedValue],
//       );
//     } else {
//       data = await db.query(tableName); // Fetch all data if no filter
//     }

//     return data
//         .map((e) => BarangStok(
//               id: e['id'],
//               nama: e[columnNama],
//               foto: e[columnFoto],
//               jumlah: e[columnJumlah],
//               kategori: e[columnKategori],
//               deskripsi: e[columnDeskripsi],
//             ))
//         .toList();
//   }
//   // Future<List<BarangStok>> read() async {
//   //   Database db = await databaseServices.getDatabase();
//   //   List data = await db.query(tableName);
//   //   List<BarangStok> stokBarang = data
//   //       .map((e) => BarangStok(
//   //             id: e['id'],
//   //             nama: e[columnNama],
//   //             foto: e[columnFoto],
//   //             jumlah: e[columnJumlah],
//   //             kategori: e[columnKategori],
//   //             deskripsi: e[columnDeskripsi],
//   //           ))
//   //       .toList();
//   //   // print("5 data pertama: ${stokBarang.take(5).map((item) => {
//   //   //       'nama': item.nama,
//   //   //       'foto': item.foto,
//   //   //       'kategori': item.kategori,
//   //   //     }).toList()}");

//   //   return stokBarang;
//   // }

//   Future<int> insert(BarangStok brg) async {
//     Database db = await databaseServices.getDatabase();
//     int brgId = await db.insert(
//       tableName,
//       {
//         columnNama: brg.nama,
//         columnFoto: brg.foto,
//         columnJumlah: brg.jumlah,
//         columnKategori: brg.kategori,
//         columnDeskripsi: brg.deskripsi,
//       },
//     );
//     print('berhasil menambahkan barang ...');
//     return brgId;
//   }

//   Future<int> update(BarangStok brg) async {
//     Database db = await databaseServices.getDatabase();
//     int brgId = await db.update(
//         tableName,
//         {
//           columnNama: brg.nama,
//           columnFoto: brg.foto,
//           columnJumlah: brg.jumlah,
//           columnKategori: brg.kategori,
//           columnDeskripsi: brg.deskripsi,
//         },
//         where: "id = ?",
//         whereArgs: [brg.id]);
//     print(brgId);
//     return brgId;
//   }

//   Future<int> updateJumlah(int id, int jumlahBaru) async {
//     Database db = await databaseServices.getDatabase();
//     int brgId = await db.update(
//       tableName,
//       {
//         columnJumlah: jumlahBaru, // hanya update jumlah
//       },
//       where: "id = ?",
//       whereArgs: [id],
//     );
//     print(brgId);
//     return brgId;
//   }

//   Future<int> delete(int id) async {
//     Database db = await databaseServices.getDatabase();
//     int jumlahTerhapus =
//         await db.delete(tableName, where: "id = ?", whereArgs: [id]);
//     print("berhasil menghapus item ...");
//     return jumlahTerhapus;
//   }

//   Future<void> insertSampleData() async {
//     List<BarangStok> sampleData = [
//       BarangStok(
//         id: 1,
//         nama: "Nastar",
//         foto: "assets/sample/k1.jpeg",
//         jumlah: 10,
//         kategori: "Kue",
//         deskripsi: "Kue coklat lezat dengan tekstur yang lembut.",
//       ),
//       BarangStok(
//         id: 2,
//         nama: "Semprit Susu",
//         foto: "assets/sample/k2.jpeg",
//         jumlah: 5,
//         kategori: "Kue",
//         deskripsi: "Kue keju dengan rasa gurih dan renyah.",
//       ),
//       BarangStok(
//         id: 3,
//         nama: "Cornflake Coklat",
//         foto: "assets/sample/k3.jpeg",
//         jumlah: 20,
//         kategori: "Kue",
//         deskripsi: "Piring plastik yang cocok untuk pesta dan piknik.",
//       ),
//       BarangStok(
//         id: 4,
//         nama: "Pisau Dapur",
//         foto: "assets/sample/b1.jpeg",
//         jumlah: 8,
//         kategori: "Alat",
//         deskripsi: "Pisau dapur tajam untuk memotong bahan masakan.",
//       ),
//       BarangStok(
//         id: 5,
//         nama: "Mainan Acak",
//         foto: "assets/sample/b2.jpeg",
//         jumlah: 15,
//         kategori: "Acak",
//         deskripsi: "Mainan acak yang bisa digunakan sebagai hadiah.",
//       ),
//       BarangStok(
//         id: 6,
//         nama: "Hiasan Dinding",
//         foto: "assets/sample/a1.jpeg",
//         jumlah: 7,
//         kategori: "Acak",
//         deskripsi: "Hiasan dinding untuk mempercantik ruangan.",
//       ),
//       BarangStok(
//         id: 7,
//         nama: "Kue Nastar",
//         foto: "assets/sample/a2.jpeg",
//         jumlah: 12,
//         kategori: "Kue",
//         deskripsi: "Kue nastar dengan isian nanas yang manis.",
//       ),
//       BarangStok(
//         id: 8,
//         nama: "Sendok Kayu",
//         foto: "assets/sample/a3.jpeg",
//         jumlah: 6,
//         kategori: "Alat",
//         deskripsi: "Sendok kayu yang cocok untuk memasak.",
//       ),
//     ];

//     for (var barang in sampleData) {
//       await insert(barang);
//     }
//   }
// }
