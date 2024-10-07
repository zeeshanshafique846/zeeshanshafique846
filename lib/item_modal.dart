// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class ItemModal {
  String heading;
  String image;
  Function() onTap;

  ItemModal({required this.heading, required this.image, required this.onTap});
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
