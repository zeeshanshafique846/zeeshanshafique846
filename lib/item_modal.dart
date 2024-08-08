// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class ItemModal {
  String text;
  String image;
  Widget child;

  ItemModal({required this.text, required this.image, required this.child});
}

class History_items_modal {
  String link;
  String type;
  DateTime dateTime;

  History_items_modal({
    required this.link,
    required this.type,
    required this.dateTime,
  });
}
