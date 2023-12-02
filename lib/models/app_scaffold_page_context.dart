import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';

class AppScaffoldPageContext {
  final BuildContext context;
  final WidgetRef ref;
  final PageDefinition page;
  final GoRouterState? state;

  AppScaffoldPageContext({
    required this.context,
    required this.ref,
    required this.page,
    required this.state,
  });
}
