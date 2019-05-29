import 'package:flutter/material.dart';

Widget ltr(Widget child) {
  return Directionality(textDirection: TextDirection.ltr, child: child);
}
