import 'package:wt_app_scaffold/app_scaffolds.dart';

final Map<ApplicationType, ApplicationBuilder> appBuilders = {
  ApplicationType.hiddenDrawer: HiddenDrawerApp.build,
  ApplicationType.bottomNavBar: BottomNavBarApp.build,
  ApplicationType.curvedNavBar: CurvedNavBarApp.build
};
