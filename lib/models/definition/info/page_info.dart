import 'package:flutter/cupertino.dart';
import 'package:wt_app_scaffold/models/definition/info/item_info.dart';
import 'package:wt_app_scaffold/models/definition/info/item_type.dart';
import 'package:wt_app_scaffold/models/definition/info/page_container.dart';

class PageInfo extends ItemInfo {
  final String tabTitle;
  final String route;
  final bool landing;
  final bool debug;

  PageInfo({
    required super.icon,
    required super.title,
    super.name,
    super.itemType,
    String? tabTitle,
    String? route,
    this.landing = false,
    this.debug = false,
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
    PageInfo? info,
  }) {
    return PageInfo(
      title: title ?? info?.title ?? this.title,
      name: name ?? info?.name ?? this.name,
      icon: icon ?? info?.icon ?? this.icon,
      tabTitle: tabTitle ?? info?.tabTitle ?? this.tabTitle,
      route: route ?? info?.route ?? info?.route ?? route,
      itemType: itemType ?? info?.itemType ?? this.itemType,
    );
  }
}
