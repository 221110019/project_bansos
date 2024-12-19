import 'package:flutter/material.dart';
import 'package:project_bansos/components/tombol_custom.dart';
import 'package:project_bansos/models/barang_stok.dart';
import 'package:project_bansos/services/auth_services.dart';
import 'package:project_bansos/services/firestore_services.dart';

class DetailBarang extends StatefulWidget {
  final BarangStok barangStok;
  const DetailBarang({super.key, required this.barangStok});

  @override
  State<DetailBarang> createState() => _DetailBarangState();
}

class _DetailBarangState extends State<DetailBarang> {
  FirestoreServices firestoreServices = FirestoreServices();
  AuthServices authServices = AuthServices();
  int itemPreorder = 0;
  void addPreorder() {
    setState(() {
      if (itemPreorder < widget.barangStok.yangDijual) {
        itemPreorder += 1;
      }
    });
  }

  void removePreorder() {
    setState(() {
      if (itemPreorder > 0) {
        itemPreorder -= 1;
      }
    });
  }

  void preorder() {
    setState(() {
      firestoreServices.createPreorder({
        'namaBarang': widget.barangStok.nama,
        'idPembeli': authServices.auth.currentUser!.uid,
        'kategori': widget.barangStok.kategori,
        'foto': widget.barangStok.foto,
        'jumlah': itemPreorder,
        'waktuPengambilan': DateTime.now()
      }, widget.barangStok);
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            child: Image(image: AssetImage(widget.barangStok.foto)),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.55,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.barangStok.nama,
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Jumlah : ${widget.barangStok.yangDijual.toString()}",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Deskripsi: ${widget.barangStok.deskripsi}')
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: removePreorder,
                              icon: Icon(
                                Icons.remove,
                                size: 40,
                              )),
                          Text(
                            itemPreorder.toString(),
                            style: TextStyle(fontSize: 30),
                          ),
                          IconButton(
                              onPressed: addPreorder,
                              icon: Icon(
                                Icons.add,
                                size: 40,
                              ))
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: TombolCustom(
                            onPressed: preorder,
                            child: Text(
                              'Preorder',
                              style: TextStyle(color: Colors.white),
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
