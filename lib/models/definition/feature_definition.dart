import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/models/app_scaffold_typedefs.dart';
import 'package:wt_app_scaffold/models/definition/info/feature_info.dart';
import 'package:wt_app_scaffold/models/definition/info/item_type.dart';
import 'package:wt_app_scaffold/models/scaffold_page_type.dart';
import 'package:wt_app_scaffold/widgets/item_control_panel.dart';

class FeatureDefinition {
  final FeatureInfo featureInfo;

  final List<PageDefinition> pages;

  const FeatureDefinition({
    required this.featureInfo,
    this.pages = const [],
  });

  AppScaffoldActionProviders get actionProviders =>
      pages.map((page) => page.actionsProviders).expand((e) => e).toList();

  AppScaffoldSettingsMapProviders get settingsProviders => Map.fromEntries(
        pages.map((page) => page.settingsProviders.entries).expand((e) => e),
      );

  factory FeatureDefinition.combine(
    FeatureInfo featureInfo, {
    List<FeatureDefinition> features = const [],
    FeatureDefinition? feature,
    List<PageDefinition> pages = const [],
    PageDefinition? page,
  }) =>
      FeatureDefinition(
        featureInfo: featureInfo,
        pages: [
          ...features.map((feature) => feature.pages).expand((e) => e),
          if (feature != null) ...feature.pages,
          ...pages,
          if (page != null) page,
        ],
      );

  FeatureDefinition copyWith({
    bool? showBottomMenu,
    bool? isHidden,
    ScaffoldPageType? scaffoldType,
    ItemType? type,
  }) =>
      FeatureDefinition(
        featureInfo: featureInfo,
        pages: pages
            .map((page) => page.copyWith(
                  showBottomMenu: showBottomMenu ?? page.showBottomMenu,
                  scaffoldType: scaffoldType ?? page.scaffoldType,
                ))
            .toList(),
      );

  ItemControlPanel createControlPanel({
    bool initiallyExpanded = false,
    ItemControlPanelType type = ItemControlPanelType.expandableAll,
  }) {
    return ItemControlPanel.from(
      itemInfo: featureInfo,
      initiallyExpanded: initiallyExpanded,
      type: type,
      actionsProviders: actionProviders,
      settingsProviders: settingsProviders,
      buildChildren: () => pages.map((page) => page.createControlPanel()).toList(),
    );
  }

  bool get isPrimary => featureInfo.itemType == ItemType.primary;
  bool get isSecondary => featureInfo.itemType == ItemType.secondary;
  bool get isHidden => featureInfo.itemType == ItemType.hidden;
}

extension AppScaffoldFeatureDefinitionListExtension on List<FeatureDefinition> {
  List<FeatureDefinition> copyWith({
    ScaffoldPageType? scaffoldType,
    bool? showBottomMenu,
    bool? isHidden,
  }) {
    return map(
      (feature) => feature.copyWith(
        scaffoldType: scaffoldType,
        showBottomMenu: showBottomMenu,
        isHidden: isHidden,
      ),
    ).toList();
  }

  List<PageDefinition> getPages() => map((feature) => feature.pages).expand((m) => m).toList();

  List<PageDefinition> getPrimaryPages() => where((feature) => feature.isPrimary)
      .map((feature) => feature.pages.where((page) => page.isPrimary))
      .expand((e) => e)
      .toList();

  List<PageDefinition> getSecondaryPages() => where((feature) => feature.isPrimary || feature.isSecondary)
      .map((feature) => feature.pages.where((page) => page.isSecondary))
      .expand((e) => e)
      .toList();

  List<PageDefinition> getHiddenPages() =>
      map((feature) => feature.pages.where((page) => page.isHidden)).expand((e) => e).toList();
}
