import 'package:flutter/material.dart';

class FilterStokOwner extends StatefulWidget {
  final Function(String)
      onSelectionChanged; // callback untuk mengirim nilai ke widget induk

  const FilterStokOwner({Key? key, required this.onSelectionChanged})
      : super(key: key);

  @override
  _FilterStokOwnerState createState() => _FilterStokOwnerState();
}

class _FilterStokOwnerState extends State<FilterStokOwner> {
  int selectedChoiceIndex = 0;
  String selectedValue = '';

  void onChipSelected(int index) {
    setState(() {
      selectedChoiceIndex = index;
      selectedValue = index == 0
          ? 'Kue'
          : index == 1
              ? 'Alat'
              : 'Acak';
    });

    widget.onSelectionChanged(selectedValue);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      children: [
        ChoiceChip(
          label: const Text('Kue'),
          selectedColor: const Color.fromRGBO(200, 0, 0, 1),
          selected: selectedChoiceIndex == 0,
          onSelected: (selected) => onChipSelected(0),
        ),
        ChoiceChip(
          label: const Text('Alat'),
          selectedColor: const Color.fromRGBO(200, 0, 0, 1),
          selected: selectedChoiceIndex == 1,
          onSelected: (selected) => onChipSelected(1),
        ),
        ChoiceChip(
          label: const Text('Acak'),
          selectedColor: const Color.fromRGBO(200, 0, 0, 1),
          selected: selectedChoiceIndex == 2,
          onSelected: (selected) => onChipSelected(2),
        ),
      ],
    );
  }
}
