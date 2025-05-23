import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/models/app_scaffold_page_context.dart';

typedef AppScaffoldPageBuilder = Widget Function(
  AppScaffoldPageContext pageContext,
);

typedef AppScaffoldPageWidgetBuilder = Widget Function(
  BuildContext context,
  WidgetRef ref,
);
