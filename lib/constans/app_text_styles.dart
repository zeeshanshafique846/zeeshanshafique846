import 'package:flutter/material.dart';

class AppTextStyles {
  static OutlineInputBorder errorBorderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(
      color: Colors.yellow.shade700,
      width: 2,
    ),
  );
  static Border containerBorder = Border.all(
    width: 2,
    color: Colors.yellow.shade700,
  );
  static TextStyle errorTextstyle = TextStyle(
    color: Colors.yellow.shade700,
    fontFamily: 'Font',
  );

  static String? Function(String?)? validator = (value) {
    if (value == '' || value == null) {
      return 'Field is required';
    } else {
      return null;
    }
  };
}
