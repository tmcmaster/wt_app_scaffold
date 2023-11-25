import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';

typedef ScaffoldBuilder = Widget Function(
  BuildContext,
  PageDefinition,
  GoRouterState?,
);
