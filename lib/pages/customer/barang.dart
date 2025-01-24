import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:project_bansos/components/list_tile_cust.dart';
import 'package:project_bansos/helper/cakap_helper.dart';
import 'package:project_bansos/helper/shortcut_helper.dart';
import 'package:project_bansos/models/barang_stok.dart';
import 'package:project_bansos/pages/customer/detail_barang.dart';
import 'package:project_bansos/services/ads_services.dart';

class Barang extends StatefulWidget {
  final searchButton;
  const Barang({super.key, required Null Function() this.searchButton});

  @override
  State<Barang> createState() => _BarangState();
}

class _BarangState extends State<Barang> {
  BannerAd? _banner;

  Widget barang(String kategori) {
    return StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('stock_barang').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: ShortcutHelper.warnaPrimary(context),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text(CakapHelper.tulisan(context)!.o_pesan_2));
          }
          List<BarangStok> barang = snapshot.data!.docs
              .map((doc) => BarangStok.fromMap({
                    'id': doc.id,
                    'nama': doc['nama'],
                    'foto': doc['foto'],
                    'jumlah': doc['jumlah'],
                    'yangDijual': doc['yangDijual'],
                    'kategori': doc['kategori'],
                    'deskripsi': doc['deskripsi'],
                    "harga": doc['harga'],
                    'kadarluasa': doc['kadarluasa']
                  }))
              .toList();
          return Container(
            padding: const EdgeInsets.only(top: 20),
            child: ListView.builder(
                itemCount: barang.length,
                itemBuilder: (context, index) {
                  return barang[index].kategori == kategori &&
                          barang[index].yangDijual != 0
                      ? ListTileCust(
                          barang: barang[index],
                          ontap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DetailBarang(
                                      barangStok: barang[index],
                                    )));
                          },
                        )
                      : const SizedBox();
                }),
          );
        });
  }

  @override
  void initState() {
    _createBannerAd();
    super.initState();
  }

  void _createBannerAd() {
    _banner = BannerAd(
        adUnitId: AdMobService.bannerAdUnitId!,
        size: AdSize.banner,
        request: const AdRequest(),
        listener: AdMobService.bannerListener)
      ..load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            dividerColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            tabs: [
              Tab(
                text: CakapHelper.tulisan(context)!.o_filter_1.toUpperCase(),
              ),
              Tab(
                text: CakapHelper.tulisan(context)!.o_filter_2.toUpperCase(),
              ),
              Tab(
                text: CakapHelper.tulisan(context)!.o_filter_3.toUpperCase(),
              ),
            ],
          ),
          automaticallyImplyLeading: false,
          title: Text(CakapHelper.tulisan(context)!.cust_barang_1),
        ),
        body: TabBarView(
            children: [barang('Kue'), barang('Alat'), barang('Acak')]),
        bottomNavigationBar: _banner == null
            ? Container()
            : Container(
                margin: const EdgeInsets.only(bottom: 12),
                height: 52,
                child: AdWidget(ad: _banner!),
              ));
  }
}
