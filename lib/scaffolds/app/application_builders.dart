import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/scaffolds/app/go_router_menu_app/go_router_app.dart';

final Map<ApplicationType, ApplicationBuilder> appBuilders = {
  ApplicationType.hiddenDrawer: HiddenDrawerApp.build,
  ApplicationType.bottomNavBar: BottomNavBarApp.build,
  ApplicationType.curvedNavBar: CurvedNavBarApp.build,
  ApplicationType.goRouterMenu: GoRouterMenuApp.build,
};
