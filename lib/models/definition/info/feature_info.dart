import 'package:flutter/cupertino.dart';
import 'package:wt_app_scaffold/models/definition/info/item_info.dart';
import 'package:wt_app_scaffold/models/definition/info/item_type.dart';

class FeatureInfo extends ItemInfo {
  FeatureInfo({
    required super.title,
    required super.icon,
    super.name,
    super.itemType,
  });

  // String get route => primaryPage.route;

  FeatureInfo copyWith({
    String? title,
    String? tabTitle,
    String? route,
    String? name,
    IconData? icon,
    ItemType? itemType,
    FeatureInfo? featureInfo,
    ItemInfo? primaryPage,
  }) {
    return FeatureInfo(
      title: title ?? featureInfo?.title ?? this.title,
      name: name ?? featureInfo?.name ?? this.name,
      icon: icon ?? featureInfo?.icon ?? this.icon,
      itemType: itemType ?? featureInfo?.itemType ?? this.itemType,
    );
  }
}
