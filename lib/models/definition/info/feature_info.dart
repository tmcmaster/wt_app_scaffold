import 'package:flutter/cupertino.dart';
import 'package:wt_app_scaffold/models/definition/info/item_info.dart';
import 'package:wt_app_scaffold/models/definition/info/item_type.dart';
import 'package:wt_app_scaffold/models/definition/info/page_container.dart';
import 'package:wt_app_scaffold/models/definition/info/page_info.dart';

class FeatureInfo extends ItemInfo with PageContainer {
  @override
  final PageInfo primaryPage;

  FeatureInfo({
    required this.primaryPage,
    required super.icon,
    required super.title,
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
    PageInfo? primaryPage,
  }) {
    return FeatureInfo(
      primaryPage: primaryPage ?? featureInfo?.primaryPage ?? this.primaryPage,
      title: title ?? featureInfo?.title ?? this.title,
      name: name ?? featureInfo?.name ?? this.name,
      icon: icon ?? featureInfo?.icon ?? this.icon,
      itemType: itemType ?? featureInfo?.itemType ?? this.itemType,
    );
  }
}
