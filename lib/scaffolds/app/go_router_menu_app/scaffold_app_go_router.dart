import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_platform/util/app_scaffold_router.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';

class ScaffoldAppGoRouter with AppScaffoldRouter {
  final Ref ref;

  ScaffoldAppGoRouter(this.ref);

  @override
  void go(String path, {Object? extra}) {
    ref.read(GoRouterMenuApp.goRouter).go(path, extra: extra);
  }

  @override
  void push(String path, {Object? extra}) {
    ref.read(GoRouterMenuApp.goRouter).push(path, extra: extra);
  }
}
