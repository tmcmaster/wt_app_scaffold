import 'package:flutter/cupertino.dart';
import 'package:wt_app_scaffold/models/definition/info/item_info.dart';
import 'package:wt_app_scaffold/models/definition/info/item_type.dart';
import 'package:wt_app_scaffold/models/definition/info/page_container.dart';

class PageInfo extends ItemInfo {
  final String tabTitle;
  final String route;

  PageInfo({
    required super.icon,
    required super.title,
    super.name,
    String? tabTitle,
    super.itemType,
    String? route,
  })  : tabTitle = tabTitle ?? title,
        route = route ?? '/$name';

  factory PageInfo.from(ItemInfo itemInfo) => itemInfo is PageInfo
      ? itemInfo
      : itemInfo is PageContainer
          ? (itemInfo as PageContainer).primaryPage
          : PageInfo(
              icon: itemInfo.icon,
              title: itemInfo.title,
              name: itemInfo.name,
            );

  PageInfo copyWith({
    String? title,
    String? tabTitle,
    String? route,
    String? name,
    IconData? icon,
    ItemType? itemType,
    PageInfo? pageInfo,
  }) {
    return PageInfo(
      title: title ?? pageInfo?.title ?? this.title,
      name: name ?? pageInfo?.name ?? this.name,
      icon: icon ?? pageInfo?.icon ?? this.icon,
      tabTitle: tabTitle ?? pageInfo?.tabTitle ?? this.tabTitle,
      route: route ?? pageInfo?.route ?? pageInfo?.route ?? route,
      itemType: itemType ?? pageInfo?.itemType ?? this.itemType,
    );
  }
}
