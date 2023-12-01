import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/providers/app_scaffolds_providers.dart';
import 'package:wt_logging/wt_logging.dart';

class AppScaffoldRouter {
  static final log = logger(AppScaffoldRouter, level: Level.debug);

  final Ref ref;
  AppScaffoldRouter(this.ref);

  void go(String path, BuildContext context) {
    final applicationType = ref.read(AppScaffoldProviders.applicationType);
    log.d('Routing to $path in $applicationType app.');
    switch (applicationType) {
      case ApplicationType.goRouterMenu:
        {
          ref.read(GoRouterMenuApp.router).go(path);
        }
      case ApplicationType.hiddenDrawer:
        {
          ref.read(HiddenDrawerApp.router).go(path);
        }
      case ApplicationType.bottomNavBar:
        {
          ref.read(BottomNavBarApp.router).go(path);
        }
      case ApplicationType.curvedNavBar:
        {
          ref.read(CurvedNavBarApp.router).changePage(path);
        }
      case ApplicationType.affinityApp:
        {
          context.go(path);
        }
    }
  }
}
