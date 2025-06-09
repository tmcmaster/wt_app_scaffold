import 'package:flutter/cupertino.dart';
import 'package:wt_app_scaffold/models/definition/info/item_info.dart';
import 'package:wt_app_scaffold/models/definition/info/item_type.dart';

class ModuleInfo extends ItemInfo {
  ModuleInfo({
    required super.title,
    required super.icon,
    super.name,
    super.itemType,
  });

  ModuleInfo copyWith({
    String? title,
    String? tabTitle,
    String? route,
    String? name,
    IconData? icon,
    ItemType? itemType,
    ModuleInfo? moduleInfo,
    ItemInfo? primaryPage,
  }) {
    return ModuleInfo(
      title: title ?? moduleInfo?.title ?? this.title,
      name: name ?? moduleInfo?.name ?? this.name,
      icon: icon ?? moduleInfo?.icon ?? this.icon,
      itemType: itemType ?? moduleInfo?.itemType ?? this.itemType,
    );
  }
}
