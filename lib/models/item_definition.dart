import 'package:flutter/material.dart';

abstract class ItemDefinition {
  final String title;
  final IconData icon;
  final bool debug;
  final bool primary;
  final String? _tabTitle;

  const ItemDefinition({
    required this.title,
    required this.icon,
    this.debug = false,
    this.primary = false,
    String? tabTitle,
  }) : _tabTitle = tabTitle;

  String get tabTitle => _tabTitle ?? title;
}
