import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/models/app_scaffold_typedefs.dart';
import 'package:wt_app_scaffold/models/definition/feature_definition.dart';
import 'package:wt_app_scaffold/models/definition/info/page_info.dart';
import 'package:wt_app_scaffold/models/definition/module_definition.dart';
import 'package:wt_app_scaffold/models/scaffold_page_type.dart';
import 'package:wt_app_scaffold/widgets/item_control_panel.dart';
import 'package:wt_app_scaffold/widgets/placeholder_page.dart';

class AppDefinition {
  final String appTitle;
  final String appName;
  final ProviderBase<AppDetails>? appDetailsProvider;

  final PageDefinition profilePage;
  final bool swipeEnabled;
  final List<ModuleDefinition> _modules;
  final List<FeatureDefinition> _features;
  final List<PageDefinition> _pages;

  final bool includeAppBar;
  final void Function(BuildContext context)? dismissAction;
  final void Function(BuildContext context)? menuAction;
  final List<LocalizationsDelegate>? localizationDelegates;
  final ApplicationType? applicationType;
  final ScaffoldPageType? scaffoldPageType;
  final ThemeMode? themeMode;
  final Color? colorScheme;
  final List<LocalizationsDelegate> intlDelegates;
  final Set<Locale>? intlLocales;

  AppDefinition._({
    required this.appTitle,
    required this.appName,
    required this.appDetailsProvider,
    required this.profilePage,
    List<PageDefinition> pages = const [],
    List<FeatureDefinition> features = const [],
    List<ModuleDefinition> modules = const [],
    required this.swipeEnabled,
    required this.includeAppBar,
    required this.dismissAction,
    required this.menuAction,
    required this.localizationDelegates,
    this.applicationType,
    this.scaffoldPageType,
    this.themeMode,
    this.colorScheme,
    this.intlLocales,
    this.intlDelegates = const <LocalizationsDelegate>[],
  })  : _pages = pages.copyWith(
          showBottomMenu: true,
          scaffoldType: scaffoldPageType,
        ),
        _features = features.copyWith(
          showBottomMenu: true,
          scaffoldType: scaffoldPageType,
        ),
        _modules = modules.copyWith(
          showBottomMenu: true,
          scaffoldType: scaffoldPageType,
        );

  List<PageDefinition> get pages => [
        ..._pages,
        ..._features.getPages(),
        ..._modules.getPages(),
      ];

  List<PageDefinition> get primaryPages => [
        ..._pages.getPrimaryPages(),
        ..._features.getPrimaryPages(),
        ..._modules.getPrimaryPages(),
      ];

  List<PageDefinition> get secondaryPages => [
        ..._pages.getSecondaryPages(),
        ..._features.getSecondaryPages(),
        ..._modules.getSecondaryPages(),
      ];

  List<PageDefinition> get hiddenPages => [
        ..._pages.getHiddenPages(),
        ..._features.getHiddenPages(),
        ..._modules.getHiddenPages(),
      ];

  factory AppDefinition.from({
    required String appTitle,
    required String appName,
    ProviderBase<AppDetails>? appDetailsProvider,
    PageDefinition? profilePage,
    List<PageDefinition> pages = const [],
    List<FeatureDefinition> features = const [],
    List<ModuleDefinition> modules = const [],
    bool swipeEnabled = true,
    bool includeAppBar = false,
    void Function(BuildContext context)? dismissAction,
    void Function(BuildContext context)? menuAction,
    List<LocalizationsDelegate>? localizationDelegates,
    ApplicationType? applicationType,
    ScaffoldPageType? scaffoldPageType,
    ThemeMode? themeMode,
    Color? colorScheme,
    List<LocalizationsDelegate> intlDelegates = const <LocalizationsDelegate>[],
    Set<Locale>? intlLocales,
  }) {
    return AppDefinition._(
      appTitle: appTitle,
      appName: appName,
      appDetailsProvider: appDetailsProvider,
      profilePage: profilePage ??
          PageDefinition(
            info: PageInfo(
              title: 'Profile',
              name: 'profile',
              icon: Icons.person,
            ),
            pageBuilder: (_) => const PlaceholderPage(title: 'Profile'),
          ),
      pages: pages,
      features: features,
      modules: modules,
      swipeEnabled: swipeEnabled,
      includeAppBar: includeAppBar,
      dismissAction: dismissAction,
      menuAction: menuAction ??
          (context) {
            HiddenDrawerOpener.of(context)?.open();
          },
      localizationDelegates: localizationDelegates,
      applicationType: applicationType,
      scaffoldPageType: scaffoldPageType,
      themeMode: themeMode,
      colorScheme: colorScheme,
      intlLocales: intlLocales ?? {const Locale('en', '')},
      intlDelegates: intlDelegates,
    );
  }

  AppScaffoldActionProviders get actionProviders =>
      pages.map((page) => page.actionsProviders).expand((e) => e).toList();

  AppScaffoldSettingsMapProviders get settingsProviders => Map.fromEntries(
        pages.map((page) => page.settingsProviders.entries).expand((e) => e),
      );

  ItemControlPanel createControlPanel({
    bool initiallyExpanded = true,
    ItemControlPanelType type = ItemControlPanelType.expandableAll,
  }) {
    return ItemControlPanel.from(
      itemInfo: PageInfo(
        name: appName,
        title: appTitle,
        icon: Icons.face,
      ),
      initiallyExpanded: initiallyExpanded,
      type: type,
      actionsProviders: actionProviders,
      settingsProviders: settingsProviders,
      buildChildren: () => [
        ..._modules.map((module) => module.createControlPanel()),
        ..._features.map((module) => module.createControlPanel()),
        ..._pages.map((module) => module.createControlPanel()),
      ],
    );
  }
}
