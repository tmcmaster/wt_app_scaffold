import 'package:flutter/material.dart';
import 'package:wt_app_scaffold/models/item_definition.dart';

class PageDefinition extends ItemDefinition {
  final bool landing;
  final WidgetBuilder builder;

  PageDefinition({
    required super.title,
    required super.icon,
    super.primary,
    super.debug,
    required this.builder,
    this.landing = false,
  });
}
