import 'package:flutter/material.dart';
import 'package:project_bansos/components/tombol_custom.dart';
import 'package:project_bansos/helper/shortcut_helper.dart';
import 'package:project_bansos/models/barang_stok.dart';

class UpdateStokOwner {
  final BarangStok barang;

  UpdateStokOwner(this.barang);

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.8,
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'UPDATE STOK',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ShortcutHelper.warnaPrimary(context)),
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                child: Image.asset(barang.foto),
              ),
              const SizedBox(height: 10),
              Text(
                "[${(barang.kategori).toUpperCase()}] - ${barang.nama}",
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                'Stok: ${barang.jumlah}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              UpdateCounter(barang: barang),
              const SizedBox(height: 20),
              TombolCustom(onPressed: () {}, child: const Text("SELESAI"))
            ],
          ),
        );
      },
    );
  }
}

class UpdateCounter extends StatefulWidget {
  final BarangStok barang;

  const UpdateCounter({super.key, required this.barang});

  @override
  State<UpdateCounter> createState() => _UpdateCounterState();
}

class _UpdateCounterState extends State<UpdateCounter> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TombolCustom(
          onPressed: () {
            widget.barang.kurangBarang();
            setState(() {});
          },
          filled: false,
          child: const Icon(Icons.remove),
        ),
        Text("${widget.barang.jumlah}"),
        TombolCustom(
            filled: false,
            onPressed: () {
              widget.barang.tambahBarang();
              setState(() {});
            },
            child: const Icon(Icons.add)),
      ],
    );
  }
}
