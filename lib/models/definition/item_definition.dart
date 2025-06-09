import 'package:flutter/cupertino.dart';
import 'package:wt_app_scaffold/models/definition/info/item_info.dart';

abstract class ItemDefinition<T extends ItemInfo> {
  final T info;
  final bool debug;

  const ItemDefinition({
    required this.info,
    this.debug = false,
  });

  @Deprecated('Need to migrate to directly using the PageInfo')
  String get title => info.title;
  @Deprecated('Need to migrate to directly using the PageInfo')
  String get name => info.name;
  @Deprecated('Need to migrate to directly using the PageInfo')
  IconData get icon => info.icon;
}
