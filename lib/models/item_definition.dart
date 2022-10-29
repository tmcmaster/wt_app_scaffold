import 'package:flutter/material.dart';

abstract class ItemDefinition {
  final String title;
  final IconData icon;
  final bool debug;

  ItemDefinition({
    required this.title,
    required this.icon,
    this.debug = false,
  });
}
