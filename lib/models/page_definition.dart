import 'package:flutter/material.dart';
import 'package:wt_app_scaffold/models/drawer_builder.dart';
import 'package:wt_app_scaffold/models/item_definition.dart';
import 'package:wt_app_scaffold/models/page_builder.dart';
import 'package:wt_app_scaffold/models/scaffold_page_type.dart';

class PageDefinition extends ItemDefinition {
  final String? name;
  final bool landing;
  final AppScaffoldPageBuilder builder;
  final DrawerBuilder? drawerBuilder;
  final List<PageDefinition> childPages;
  final ScaffoldPageType? scaffoldType;
  final bool centerTitle;
  final bool showAppBar;
  final bool showBottomMenu;
  final String? homeRoute;
  PageDefinition({
    this.name,
    required super.title,
    super.tabTitle,
    required super.icon,
    super.primary,
    super.debug,
    required this.builder,
    this.drawerBuilder,
    this.landing = false,
    this.childPages = const [],
    this.scaffoldType,
    this.centerTitle = true,
    this.showAppBar = false,
    this.showBottomMenu = false,
    this.homeRoute,
  });

  String get route => '/${name ?? title.replaceAll(' ', '_').toLowerCase()}';

  PageDefinition copyWith({
    String? name,
    String? title,
    String? tabTitle,
    IconData? icon,
    bool? primary,
    bool? debug,
    bool? landing,
    AppScaffoldPageBuilder? builder,
    DrawerBuilder? drawerBuilder,
    List<PageDefinition>? childPages,
    ScaffoldPageType? scaffoldType,
    bool? centerTitle,
    bool? showAppBar,
    bool? showBottomMenu,
    String? homeRoute,
  }) {
    return PageDefinition(
      name: name ?? this.name,
      title: title ?? this.title,
      tabTitle: tabTitle ?? this.tabTitle,
      icon: icon ?? this.icon,
      primary: primary ?? this.primary,
      debug: debug ?? this.debug,
      landing: landing ?? this.landing,
      builder: builder ?? this.builder,
      drawerBuilder: drawerBuilder ?? this.drawerBuilder,
      childPages: childPages ?? this.childPages,
      scaffoldType: scaffoldType ?? this.scaffoldType,
      centerTitle: centerTitle ?? this.centerTitle,
      showAppBar: showAppBar ?? this.showAppBar,
      showBottomMenu: showBottomMenu ?? this.showBottomMenu,
      homeRoute: homeRoute ?? this.homeRoute,
    );
  }
}
