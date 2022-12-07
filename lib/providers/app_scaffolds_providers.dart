import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/init/provider_manager.dart';

import '../models/app_details.dart';

abstract class AppScaffoldProviders {
  static final appDetails = Provider<AppDetails>(
    name: 'AppScaffoldProviders.appDetails',
    (ref) {
      return AppDetails(
        title: 'Application Name',
        subTitle: 'Site Name',
        iconPath: 'assets/avocado.png',
      );
    },
  );

  static final providerManager = Provider<ProviderManager>(
    name: 'Provider Manager',
    (ref) => ProviderManager(),
  );

  static final navigatorKey = Provider<GlobalKey<NavigatorState>>(
    name: 'AppScaffoldProviders.navigatorKey',
    (ref) => GlobalKey<NavigatorState>(),
  );
}
