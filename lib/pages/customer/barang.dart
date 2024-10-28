import 'package:flutter/material.dart';
import 'package:project_bansos/components/list_tile_cust.dart';
import 'package:project_bansos/pages/customer/detail_barang.dart';

class Barang extends StatefulWidget {
  final searchButton;
  const Barang({super.key, required Null Function() this.searchButton});

  @override
  State<Barang> createState() => _BarangState();
}

class _BarangState extends State<Barang> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: const TabBar(
          dividerColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
          tabs: [
            Tab(icon: Icon(Icons.food_bank)),
            Tab(icon: Icon(Icons.directions_transit)),
            Tab(icon: Icon(Icons.directions_bike)),
          ],
        ),
        automaticallyImplyLeading: false,
        title: Text('Barang'),
        actions: [
          IconButton(onPressed: widget.searchButton, icon: Icon(Icons.search))
        ],
      ),
      body: TabBarView(children: [
        Container(
          padding: EdgeInsets.only(top: 20),
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTileCust(
                  imageUrl: 'assets/pictures/semprit-susu.jpg',
                  itemName: 'kue semprit',
                  itemCount: 2,
                  preorder: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DetailBarang(
                              imageUrl: 'assets/pictures/semprit-susu.jpg',
                              itemName: 'kue semprit',
                              itemCount: 2,
                              desc:
                                  "Lezat dan bergiziLezat dan bergiziLezat dan bergiziLezat dan bergiziLezat dan bergiziLezat dan bergiziLezat dan bergiziLezat dan bergiziLezat dan bergiziLezat dan bergiziLezat dan bergiziLezat dan bergiziLezat dan bergiziLezat dan bergiziLezat dan bergizi",
                            )));
                  },
                );
              }),
        ),
        Container(),
        Container()
      ]),
    );
  }
}
