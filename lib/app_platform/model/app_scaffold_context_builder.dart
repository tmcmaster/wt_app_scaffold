import 'package:wt_app_scaffold/app_platform/model/app_scaffold_context_map.dart';

typedef AppScaffoldContextBuilder = Future<AppScaffoldContextMap> Function(
  AppScaffoldContextMap contextMap,
);
