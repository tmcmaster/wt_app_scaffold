import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';

typedef AppScaffoldPageBuilder = Widget Function(
  BuildContext context,
  WidgetRef ref,
  PageDefinition pageDefinition,
  GoRouterState? state,
);
