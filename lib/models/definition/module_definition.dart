import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/models/app_scaffold_typedefs.dart';
import 'package:wt_app_scaffold/models/definition/feature_definition.dart';
import 'package:wt_app_scaffold/models/definition/info/item_type.dart';
import 'package:wt_app_scaffold/models/definition/info/module_info.dart';
import 'package:wt_app_scaffold/models/scaffold_page_type.dart';
import 'package:wt_app_scaffold/widgets/item_control_panel.dart';

class ModuleDefinition {
  final ModuleInfo moduleInfo;
  final List<FeatureDefinition> features;

  const ModuleDefinition({
    required this.moduleInfo,
    this.features = const [],
  });

  List<PageDefinition> get pages => features.map((feature) => feature.pages).expand((m) => m).toList();

  AppScaffoldActionProviders get actionProviders =>
      features.map((feature) => feature.actionProviders).expand((e) => e).toList();

  AppScaffoldSettingsMapProviders get settingsProviders => Map.fromEntries(
        pages.map((page) => page.settingsProviders.entries).expand((e) => e),
      );

  factory ModuleDefinition.combine(
    ModuleInfo moduleInfo, {
    List<ModuleDefinition> modules = const [],
    ModuleDefinition? module,
    List<FeatureDefinition> features = const [],
    FeatureDefinition? feature,
  }) =>
      ModuleDefinition(
        moduleInfo: moduleInfo,
        features: [
          ...modules.map((module) => module.features).expand((e) => e),
          if (module != null) ...module.features,
          ...features,
          if (feature != null) feature,
        ],
      );

  ModuleDefinition copyWith({
    bool? showBottomMenu,
    bool? primary,
    bool? isHidden,
    ScaffoldPageType? scaffoldType,
  }) =>
      ModuleDefinition(
        moduleInfo: moduleInfo,
        features: features
            .map((feature) => feature.copyWith(
                  showBottomMenu: showBottomMenu,
                  primary: primary,
                  isHidden: isHidden,
                  scaffoldType: scaffoldType,
                ))
            .toList(),
      );

  ItemControlPanel createControlPanel({
    bool initiallyExpanded = false,
    ItemControlPanelType type = ItemControlPanelType.expandableAll,
  }) {
    return ItemControlPanel.from(
      itemInfo: moduleInfo,
      initiallyExpanded: initiallyExpanded,
      type: type,
      actionsProviders: actionProviders,
      settingsProviders: settingsProviders,
      buildChildren: () => features.map((feature) => feature.createControlPanel()).toList(),
    );
  }

  bool get isPrimary => moduleInfo.itemType == ItemType.primary;
  bool get isSecondary => moduleInfo.itemType == ItemType.secondary;
  bool get isHidden => moduleInfo.itemType == ItemType.hidden;
}

extension AppScaffoldModuleDefinitionListExtension on List<ModuleDefinition> {
  List<ModuleDefinition> copyWith({
    bool? primary,
    ScaffoldPageType? scaffoldType,
    bool? showBottomMenu,
    bool? isHidden,
  }) {
    return map(
      (module) => module.copyWith(
        primary: primary,
        scaffoldType: scaffoldType,
        showBottomMenu: showBottomMenu,
        isHidden: isHidden,
      ),
    ).toList();
  }

  List<PageDefinition> getPages() {
    return map((module) => module.pages).expand((m) => m).toList();
  }

  List<PageDefinition> getPrimaryPages() =>
      where((module) => module.isPrimary).map((module) => module.features.getPrimaryPages()).expand((e) => e).toList();

  List<PageDefinition> getSecondaryPages() => where((module) => module.isPrimary || module.isSecondary)
      .map((feature) => feature.features.getSecondaryPages())
      .expand((e) => e)
      .toList();

  List<PageDefinition> getHiddenPages() =>
      map((feature) => feature.pages.where((page) => page.isHidden)).expand((e) => e).toList();
}
