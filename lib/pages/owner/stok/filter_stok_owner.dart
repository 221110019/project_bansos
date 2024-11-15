import 'package:flutter/material.dart';

class FilterStokOwner extends StatefulWidget {
  final Function(String) onSelectionChanged;

  const FilterStokOwner({Key? key, required this.onSelectionChanged})
      : super(key: key);

  @override
  _FilterStokOwnerState createState() => _FilterStokOwnerState();
}

class _FilterStokOwnerState extends State<FilterStokOwner> {
  int selectedChoiceIndex = 0; // Default selected chip index
  String selectedValue = 'Kue'; // Default selected category

  @override
  void initState() {
    super.initState();
    // Notify parent widget (StokOwner) of the initial selection
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onSelectionChanged(selectedValue);
    });
  }

  // Function to handle chip selection
  void onChipSelected(int index) {
    if (selectedChoiceIndex != index) {
      setState(() {
        selectedChoiceIndex = index;
        // Update the selected category based on the selected chip
        selectedValue = index == 0
            ? 'Kue'
            : index == 1
                ? 'Alat'
                : 'Acak';
      });
      // Notify the parent widget about the category change
      widget.onSelectionChanged(selectedValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 8.0, // Horizontal spacing between chips
        runSpacing: 4.0, // Vertical spacing between chips
        children: [
          ChoiceChip(
            label: const Text('Kue'),
            selectedColor: const Color.fromRGBO(200, 0, 0, 1), // Red color
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
      ),
    );
  }
}
