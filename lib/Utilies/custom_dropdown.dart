import 'package:flutter/material.dart';

final List<String> items = ['Admin', 'User', 'Maintainer'];
// String? selectedValue;

List<DropdownMenuItem<String>> addDividersAfterItems(List<String> items) {
  final List<DropdownMenuItem<String>> menuItems = [];
  for (final String item in items) {
    menuItems.addAll(
      [
        DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
  return menuItems;
}
