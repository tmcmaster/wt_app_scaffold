import 'package:flutter/material.dart';

mixin ThemeStyles {
  static final buttonStyle = ButtonStyle(
    padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );
}
