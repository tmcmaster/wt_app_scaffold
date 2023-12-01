import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/scaffolds/app/affinity_app/affinity_app.dart';

enum ApplicationType {
  hiddenDrawer(HiddenDrawerApp.build),
  bottomNavBar(BottomNavBarApp.build),
  curvedNavBar(CurvedNavBarApp.build),
  goRouterMenu(GoRouterMenuApp.build),
  affinityApp(AffinityApp.build);

  final ApplicationBuilder builder;

  const ApplicationType(this.builder);
}
