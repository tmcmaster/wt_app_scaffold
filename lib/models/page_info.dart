import 'package:flutter/widgets.dart';

class PageInfo {
  final String title;
  final String tabTitle;
  final String name;
  final IconData icon;
  const PageInfo({
    required this.title,
    required this.name,
    required this.icon,
    String? tabTitle,
  }) : tabTitle = tabTitle ?? title;

  String get route => '/$name';
}
