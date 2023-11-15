import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wt_app_scaffold/models/item_definition.dart';

typedef PageBuilder = Widget Function(
  BuildContext context,
  PageDefinition pageDefinition,
  GoRouterState? state,
);

typedef DrawerBuilder = Widget Function(
  BuildContext context,
);

enum ScaffoldType {
  transparentCard,
  plain,
}

class PageDefinition extends ItemDefinition {
  final String? name;
  final bool landing;
  final PageBuilder builder;
  final DrawerBuilder? drawerBuilder;
  final List<PageDefinition> childPages;
  final ScaffoldType scaffoldType;
  PageDefinition({
    this.name,
    required super.title,
    required super.icon,
    super.primary,
    super.debug,
    required this.builder,
    this.drawerBuilder,
    this.landing = false,
    this.childPages = const [],
    this.scaffoldType = ScaffoldType.plain,
  });

  String get route => '/${name ?? title.replaceAll(' ', '_').toLowerCase()}';
}
