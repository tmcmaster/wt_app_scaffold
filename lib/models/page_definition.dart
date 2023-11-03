import 'package:flutter/material.dart';
import 'package:wt_app_scaffold/models/item_definition.dart';

typedef PageBuilder = Widget Function(
  BuildContext context,
  PageDefinition pageDefinition,
);

class PageDefinition extends ItemDefinition {
  final bool landing;
  final PageBuilder builder;
  final List<PageDefinition> childPages;
  PageDefinition({
    required super.title,
    required super.icon,
    super.primary,
    super.debug,
    required this.builder,
    this.landing = false,
    this.childPages = const [],
  });
}
