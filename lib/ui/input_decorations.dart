import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration primary({
    required String hintText,
    required String labelText,
    required IconData icon,
  }) =>
      InputDecoration(
        hintText: hintText,
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.grey),
        prefixIcon: Icon(icon, color: Colors.black12),
      );
}
