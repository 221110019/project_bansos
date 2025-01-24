import 'package:flutter/material.dart';
import 'package:project_bansos/helper/cakap_helper.dart';
import 'package:project_bansos/provider/filter_stock_provider.dart';
import 'package:provider/provider.dart';

class FilterStokOwner extends StatefulWidget {
  const FilterStokOwner({super.key});

  @override
  FilterStokOwnerState createState() => FilterStokOwnerState();
}

class FilterStokOwnerState extends State<FilterStokOwner> {
  void onChipSelected(int index) {
    if (Provider.of<FilterStockProvider>(context, listen: false)
            .selectedChoiceIndex !=
        index) {
      setState(() {
        Provider.of<FilterStockProvider>(context, listen: false)
            .changeSelectedChoice(index);
        Provider.of<FilterStockProvider>(context, listen: false)
            .changeSelectedValue(index == 0
                ? "Kue"
                : index == 1
                    ? "Alat"
                    : "Acak");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 4.0,
        children: [
          ChoiceChip(
            label: Text(CakapHelper.tulisan(context)!.o_filter_1),
            selectedColor: const Color.fromRGBO(200, 0, 0, 1), // Red color
            selected:
                context.watch<FilterStockProvider>().selectedChoiceIndex == 0,
            onSelected: (selected) => onChipSelected(0),
          ),
          ChoiceChip(
            label: Text(CakapHelper.tulisan(context)!.o_filter_2),
            selectedColor: const Color.fromRGBO(200, 0, 0, 1),
            selected:
                context.watch<FilterStockProvider>().selectedChoiceIndex == 1,
            onSelected: (selected) => onChipSelected(1),
          ),
          ChoiceChip(
            label: Text(CakapHelper.tulisan(context)!.o_filter_3),
            selectedColor: const Color.fromRGBO(200, 0, 0, 1),
            selected:
                context.watch<FilterStockProvider>().selectedChoiceIndex == 2,
            onSelected: (selected) => onChipSelected(2),
          ),
        ],
      ),
    );
  }
}
