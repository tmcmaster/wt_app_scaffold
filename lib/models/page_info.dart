import 'package:flutter/cupertino.dart';
import 'package:wt_app_scaffold/models/item_info.dart';

class PageInfo extends ItemInfo {
  const PageInfo({
    required super.name,
    required super.title,
    super.tabTitle,
    required super.icon,
  });

  @override
  PageInfo copyWith({
    String? title,
    String? tabTitle,
    String? name,
    IconData? icon,
    ItemInfo? itemInfo,
  }) {
    final copied = super.copyWith(
      title: title,
      tabTitle: tabTitle,
      name: name,
      icon: icon,
      itemInfo: itemInfo,
    );
    return PageInfo(
      title: copied.title,
      name: copied.name,
      icon: copied.icon,
      tabTitle: copied.tabTitle,
    );
  }
}
