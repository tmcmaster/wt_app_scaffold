import 'package:flutter/material.dart';

import 'item_definition.dart';

class PageDefinition extends ItemDefinition {
  final WidgetBuilder builder;

  PageDefinition({
    required super.title,
    required super.icon,
    super.debug,
    required this.builder,
  });
}
