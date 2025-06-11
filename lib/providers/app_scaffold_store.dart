import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/action_button_definition.dart';
import 'package:wt_app_definition/app_definition.dart';
import 'package:wt_app_scaffold/app_platform/auth/app_scaffold_logout_action.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/scaffolds/app/affinity_app/affinity_app_router.dart';
import 'package:wt_app_scaffold/scaffolds/app/hidden_drawer_app/hidden_draw_controller.dart';
import 'package:wt_app_scaffold/scaffolds/application_type.dart';
import 'package:wt_app_scaffold/scaffolds/common/types/app_scaffold_router.dart';
import 'package:wt_logging/wt_logging.dart';

mixin AppScaffoldStore {
  static final logoutAction = Provider<ActionButtonDefinition>(
    name: 'AppScaffoldLogoutAction.provider',
    (ref) => AppScaffoldLogoutAction(ref),
  );

  static final loginEnabled = Provider<bool>(
    name: 'AppScaffoldLogoutAction.loginEnabled',
    (ref) => false,
  );

  static final _routerProviders = <ApplicationType, ProviderListenable<AppScaffoldRouter>>{
    ApplicationType.affinityApp: AffinityAppRouter.router,
    ApplicationType.bottomNavBar: BottomNavBarApp.router,
    ApplicationType.curvedNavBar: CurvedNavBarApp.router,
    ApplicationType.goRouterMenu: GoRouterMenuApp.router,
    ApplicationType.hiddenDrawer: HiddenDrawPageController.router,
  };

  static final specifiedApplicationType = Provider<ApplicationType?>(
    name: 'Specified Application Type',
    (_) => null,
  );

  static final applicationType = Provider<ApplicationType>(
    name: 'Application Type',
    (ref) => ref.read(specifiedApplicationType) ?? ref.watch(ApplicationSettings.applicationType.value),
  );

  static final router = Provider(name: 'AppScaffold Router Provider', (ref) {
    final ApplicationType type = ref.read(applicationType);

    if (_routerProviders.containsKey(type)) {
      return ref.read(_routerProviders[type]!);
    } else {
      throw Exception('There is no router registered for ApplicationType: $type');
    }
  });

  static final navigatorKey = Provider<GlobalKey<NavigatorState>>(
    name: 'AppScaffoldProviders.navigatorKey',
    (ref) {
      ref.watch(applicationType);
      return ref.read(UserLogStore.navigatorKey.notifier).generateNewKey();
    },
  );

  static final snackBarKey = Provider<GlobalKey<ScaffoldMessengerState>>(
    name: 'AppScaffoldProviders.navigatorKey',
    (ref) {
      ref.watch(applicationType);
      return ref.read(UserLogStore.snackBarKey.notifier).generateNewKey();
    },
  );

  static final appDetails = Provider<AppDetails>(
    name: 'AppScaffoldProviders.appDetails',
    (ref) => ref.watch(AppDefinition.provider).appDetails,
  );

  static final appStyles = Provider<AppStyles>(
    name: 'AppScaffoldProviders.appStyles',
    (ref) => throw Exception(
      'AppScaffoldProviders.appStyles provider needs to be overridden.',
    ),
  );
}
