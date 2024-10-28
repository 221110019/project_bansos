import 'package:flutter/material.dart';
import 'package:project_bansos/components/tombol_custom.dart';

class DetailBarang extends StatefulWidget {
  final String imageUrl;
  final String itemName;
  final int itemCount;
  final String desc;
  const DetailBarang(
      {super.key,
      required this.imageUrl,
      required this.itemName,
      required this.itemCount,
      required this.desc});

  @override
  State<DetailBarang> createState() => _DetailBarangState();
}

class _DetailBarangState extends State<DetailBarang> {
  int itemPreorder = 0;
  void addPreorder() {
    setState(() {
      if (itemPreorder < widget.itemCount) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Image(image: AssetImage(widget.imageUrl)),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.55,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.itemName,
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Jumlah : ${widget.itemCount.toString()}",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(widget.desc)
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
                            onPressed: () {},
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
