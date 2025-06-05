import 'package:flutter/cupertino.dart';
import 'package:wt_app_scaffold/models/definition/info/item_type.dart';
import 'package:wt_app_scaffold/utils/string_extensions.dart';

abstract class ItemInfo {
  final String title;
  final String name;
  final IconData icon;
  final ItemType itemType;

  ItemInfo({
    required this.title,
    required this.icon,
    String? name,
    this.itemType = ItemType.secondary,
  }) : name = name ?? title.toLowerCamelCase();
}
