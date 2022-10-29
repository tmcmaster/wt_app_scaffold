import 'package:wt_app_scaffold/app_scaffolds.dart';

abstract class DemoAppProviders {
  static final appDetails = Provider<AppDetails>(
    name: 'DemoAppProviders.appDetails',
    (ref) {
      return AppDetails(
        title: 'Demo App',
        subTitle: 'site one',
        iconPath: 'assets/avocado.png',
      );
    },
  );
}
