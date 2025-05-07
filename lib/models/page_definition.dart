import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/action_button_definition.dart';
import 'package:wt_app_scaffold/models/drawer_builder.dart';
import 'package:wt_app_scaffold/models/item_definition.dart';
import 'package:wt_app_scaffold/models/page_builder.dart';
import 'package:wt_app_scaffold/models/page_info.dart';
import 'package:wt_app_scaffold/models/scaffold_page_type.dart';
import 'package:wt_logging/wt_logging.dart';
import 'package:wt_settings/wt_settings.dart';

class PageDefinition extends ItemDefinition {
  static final log = logger(PageDefinition, level: Level.debug);

  final bool landing;
  final AppScaffoldPageBuilder? pageBuilder;
  final AppScaffoldPageBuilder? pageContentBuilder;
  final DrawerBuilder? drawerBuilder;
  final List<PageDefinition> childPages;
  final ScaffoldPageType? scaffoldType;
  final bool centerTitle;
  final bool showAppBar;
  final bool hideBackButton;
  final bool showBottomMenu;
  final bool registerChildRoutes;
  final String? homeRoute;
  final List<ProviderBase<ActionButtonDefinition>> actionsProviders;
  final List<BaseSettingsProviders> settingsProviders;
  final Widget Function()? pageBodyBuilder;

  const PageDefinition({
    required super.pageInfo,
    super.primary,
    super.debug,
    this.pageBuilder,
    this.pageContentBuilder,
    this.drawerBuilder,
    this.landing = false,
    this.childPages = const [],
    this.scaffoldType,
    this.centerTitle = true,
    this.showAppBar = false,
    this.showBottomMenu = false,
    this.registerChildRoutes = false,
    this.homeRoute,
    this.actionsProviders = const [],
    this.settingsProviders = const [],
    this.pageBodyBuilder,
    this.hideBackButton = false,
  });

  String get route => '/${pageInfo.name}';

  PageDefinition copyWith({
    PageInfo? pageInfo,
    String? name,
    String? title,
    String? tabTitle,
    IconData? icon,
    bool? primary,
    bool? debug,
    bool? landing,
    AppScaffoldPageBuilder? pageBuilder,
    AppScaffoldPageBuilder? pageContentBuilder,
    DrawerBuilder? drawerBuilder,
    List<PageDefinition>? childPages,
    ScaffoldPageType? scaffoldType,
    bool? centerTitle,
    bool? showAppBar,
    bool? showBottomMenu,
    bool? hideBackButton,
    String? homeRoute,
    List<ProviderBase<ActionButtonDefinition>>? actionsProviders,
    List<BaseSettingsProviders>? settingsProviders,
  }) {
    return PageDefinition(
      pageInfo: this.pageInfo.copyWith(
            name: name,
            title: title,
            tabTitle: tabTitle,
            icon: icon,
            pageInfo: pageInfo,
          ),
      primary: primary ?? this.primary,
      debug: debug ?? this.debug,
      landing: landing ?? this.landing,
      pageBuilder: pageBuilder ?? this.pageBuilder,
      pageContentBuilder: pageContentBuilder ?? this.pageContentBuilder,
      drawerBuilder: drawerBuilder ?? this.drawerBuilder,
      childPages: childPages ?? this.childPages,
      scaffoldType: scaffoldType ?? this.scaffoldType,
      centerTitle: centerTitle ?? this.centerTitle,
      showAppBar: showAppBar ?? this.showAppBar,
      hideBackButton: hideBackButton ?? this.hideBackButton,
      showBottomMenu: showBottomMenu ?? this.showBottomMenu,
      homeRoute: homeRoute ?? this.homeRoute,
      actionsProviders: actionsProviders ?? this.actionsProviders,
      settingsProviders: settingsProviders ?? this.settingsProviders,
    );
  }
}
