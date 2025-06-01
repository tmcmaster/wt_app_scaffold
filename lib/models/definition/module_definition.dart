import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/models/app_scaffold_typedefs.dart';
import 'package:wt_app_scaffold/models/definition/feature_definition.dart';
import 'package:wt_app_scaffold/models/item_info.dart';
import 'package:wt_app_scaffold/widgets/item_control_panel.dart';

class ModuleDefinition {
  final ItemInfo itemInfo;
  final List<FeatureDefinition> features;

  const ModuleDefinition({
    required this.itemInfo,
    this.features = const [],
  });

  List<PageDefinition> get pages => features.map((feature) => feature.pages).expand((m) => m).toList();

  AppScaffoldActionProviders get actionProviders =>
      features.map((feature) => feature.actionProviders).expand((e) => e).toList();

  AppScaffoldSettingsMapProviders get settingsProviders => Map.fromEntries(
        pages.map((page) => page.settingsProviders.entries).expand((e) => e),
      );

  ItemControlPanel createControlPanel({
    bool initiallyExpanded = false,
    ItemControlPanelType type = ItemControlPanelType.expandableAll,
  }) {
    return ItemControlPanel.from(
      itemInfo: itemInfo,
      initiallyExpanded: initiallyExpanded,
      type: type,
      actionsProviders: actionProviders,
      settingsProviders: settingsProviders,
      buildChildren: () => features.map((feature) => feature.createControlPanel()).toList(),
    );
  }
}
