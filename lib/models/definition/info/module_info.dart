import 'package:flutter/cupertino.dart';
import 'package:wt_app_scaffold/models/definition/info/feature_info.dart';
import 'package:wt_app_scaffold/models/definition/info/item_info.dart';
import 'package:wt_app_scaffold/models/definition/info/item_type.dart';
import 'package:wt_app_scaffold/models/definition/info/page_container.dart';
import 'package:wt_app_scaffold/models/definition/info/page_info.dart';

class ModuleInfo extends ItemInfo with PageContainer {
  final FeatureInfo primaryFeature;

  ModuleInfo({
    required this.primaryFeature,
    required super.icon,
    required super.title,
    super.name,
    super.itemType,
  });

  @override
  PageInfo get primaryPage => primaryFeature.primaryPage;

  ModuleInfo copyWith({
    String? title,
    String? tabTitle,
    String? route,
    String? name,
    IconData? icon,
    ItemType? itemType,
    ModuleInfo? moduleInfo,
    PageInfo? primaryPage,
  }) {
    return ModuleInfo(
      primaryFeature: primaryFeature ?? moduleInfo?.primaryFeature ?? this.primaryFeature,
      title: title ?? moduleInfo?.title ?? this.title,
      name: name ?? moduleInfo?.name ?? this.name,
      icon: icon ?? moduleInfo?.icon ?? this.icon,
      itemType: itemType ?? moduleInfo?.itemType ?? this.itemType,
    );
  }
}
