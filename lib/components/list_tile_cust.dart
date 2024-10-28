import 'package:flutter/material.dart';
import 'package:project_bansos/components/tombol_custom.dart';

class ListTileCust extends StatelessWidget {
  final String imageUrl;
  final String itemName;
  final int itemCount;
  final VoidCallback preorder;
  const ListTileCust(
      {super.key,
      required this.imageUrl,
      required this.itemName,
      required this.itemCount,
      required this.preorder});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: Colors.red,
          ),
          Row(
            children: [
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width * 0.3,
                child: Image(fit: BoxFit.cover, image: AssetImage(imageUrl)),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Nama    : ${itemName}"),
                    Text("Jumlah  : ${itemCount.toString()}"),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TombolCustom(
                          onPressed: preorder,
                          child: Text(
                            'Preorder',
                            style: TextStyle(color: Colors.white),
                          )),
                    )
                  ],
                ),
              )
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: Colors.red,
          )
        ],
      ),
    );
  }
}
