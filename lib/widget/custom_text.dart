import 'package:flutter/material.dart';

Widget getSubTitle(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Text(
      title,
      style: const TextStyle(fontSize: 18),
    ),
  );
}
