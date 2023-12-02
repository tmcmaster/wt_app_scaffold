import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_platform/util/app_scaffold_material_app_router.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/providers/app_scaffolds_providers.dart';
import 'package:wt_app_scaffold/scaffolds/app/hidden_drawer_app/hidden_draw_controller.dart';
import 'package:wt_logging/wt_logging.dart';

mixin AppScaffoldRouter {
  static final log = logger(AppScaffoldRouter, level: Level.debug);

  static final provider = Provider<AppScaffoldRouter>(
    name: 'AppScaffoldProviders.router',
    (ref) {
      final applicationType = ref.read(AppScaffoldProviders.applicationType);
      log.d('Getting router for the ApplicationType($applicationType)');
      switch (applicationType) {
        case ApplicationType.goRouterMenu:
          return ref.read(GoRouterMenuApp.router);
        case ApplicationType.hiddenDrawer:
          return ref.read(HiddenDrawPageController.router);
        case ApplicationType.bottomNavBar:
          return ref.read(BottomNavBarApp.router);
        case ApplicationType.curvedNavBar:
          return ref.read(CurvedNavBarApp.router);
        case ApplicationType.affinityApp:
          return ref.read(AppScaffoldMaterialAppRouter.router);
      }
    },
  );

  void go(String path, {Object? extra});
}
