import 'package:flutter/cupertino.dart';
import 'package:wt_app_scaffold/models/page_info.dart';

abstract class ItemDefinition {
  final PageInfo pageInfo;
  final bool debug;
  final bool primary;

  const ItemDefinition({
    required this.pageInfo,
    this.debug = false,
    this.primary = false,
  });

  @Deprecated('Need to migrate to directly using the PageInfo')
  String get title => pageInfo.title;
  @Deprecated('Need to migrate to directly using the PageInfo')
  String get tabTitle => pageInfo.tabTitle;
  @Deprecated('Need to migrate to directly using the PageInfo')
  String get name => pageInfo.name;
  @Deprecated('Need to migrate to directly using the PageInfo')
  IconData get icon => pageInfo.icon;
}
