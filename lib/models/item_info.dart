import 'package:flutter/cupertino.dart';

class ItemInfo {
  final String title;
  final String tabTitle;
  final String name;
  final IconData icon;

  const ItemInfo({
    required this.title,
    required this.name,
    required this.icon,
    String? tabTitle,
  }) : tabTitle = tabTitle ?? title;

  String get route => '/$name';

  ItemInfo copyWith({
    String? title,
    String? tabTitle,
    String? name,
    IconData? icon,
    ItemInfo? itemInfo,
  }) {
    return ItemInfo(
      title: title ?? itemInfo?.title ?? this.title,
      name: name ?? itemInfo?.name ?? this.name,
      icon: icon ?? itemInfo?.icon ?? this.icon,
      tabTitle: tabTitle ?? itemInfo?.tabTitle ?? this.tabTitle,
    );
  }
}
