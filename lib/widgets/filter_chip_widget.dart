import 'package:flutter/material.dart';

Widget categoryChip(String label, {bool isSelected = false, required ValueChanged<bool> onSelected}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        selectedColor: const Color.fromARGB(255, 207, 135, 109),
        backgroundColor: Colors.grey.shade200,
        onSelected: onSelected,
      ),
    );
  }