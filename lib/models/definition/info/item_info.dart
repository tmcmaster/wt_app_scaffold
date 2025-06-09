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
    this.itemType = ItemType.primary,
  }) : name = name ?? title.toLowerCamelCase();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ItemInfo && runtimeType == other.runtimeType && name == other.name;

  @override
  int get hashCode => name.hashCode;
}
