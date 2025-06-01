import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/models/app_scaffold_typedefs.dart';
import 'package:wt_app_scaffold/models/item_info.dart';
import 'package:wt_app_scaffold/widgets/item_control_panel.dart';

class FeatureDefinition {
  final ItemInfo itemInfo;

  final List<PageDefinition> pages;

  const FeatureDefinition({
    required this.itemInfo,
    this.pages = const [],
  });

  AppScaffoldActionProviders get actionProviders =>
      pages.map((page) => page.actionsProviders).expand((e) => e).toList();

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
      buildChildren: () => pages.map((page) => page.createControlPanel()).toList(),
    );
  }
}
