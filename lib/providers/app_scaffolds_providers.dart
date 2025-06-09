import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_platform/util/app_scaffold_router.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/models/app_styles.dart';
import 'package:wt_logging/wt_logging.dart';

mixin AppScaffoldProviders {
  static final log = logger(AppScaffoldProviders);

  static final appDefinition = Provider<AppDefinition>(
    name: 'AppScaffoldProviders.appAppDefinition',
    (ref) => throw Exception(
      'AppScaffoldProviders.appAppDefinition provider needs to be overridden.',
    ),
  );

  static final allPages = Provider((ref) {
    final pages = ref.watch(appDefinition).pages;
    final debugMode = ref.watch(ApplicationSettings.debugMode.value);
    return pages.where((page) => debugMode || !page.debug).toList();
  });

  static final primaryPages = Provider((ref) {
    return ref.watch(appDefinition).primaryPages;
  });

  static final secondaryPages = Provider((ref) {
    return ref.watch(appDefinition).secondaryPages;
  });

  static final appPrimaryPages = Provider(
    name: 'AppScaffoldProviders.appPrimaryPages',
    (ref) {
      return ref.watch(allPages).where((page) => page.isPrimary && !page.isHidden).toList();
    },
  );

  static final appSecondaryPages = Provider(
    name: 'AppScaffoldProviders.appSecondaryPages',
    (ref) {
      return ref.watch(allPages).where((page) => !page.isPrimary && !page.isHidden).toList();
    },
  );

  static final appInitialPageIndex = Provider(
    name: 'AppScaffoldProviders.appInitialPageIndex',
    (ref) {
      final pages = ref.watch(allPages);
      final landingPages = pages.where((page) => page.isLanding);
      final initialPage = [...landingPages, ...pages].first;
      landingPages.isEmpty ? pages.first : landingPages.first;
      final pageIndex = pages.indexOf(initialPage);
      return pageIndex < 0 ? 0 : pageIndex;
    },
  );

  static final appDetails = Provider<AppDetails>(
    name: 'AppScaffoldProviders.appDetails',
    (ref) => throw Exception(
      'AppScaffoldProviders.appDetails provider needs to be overridden.',
    ),
  );

  static final appStyles = Provider<AppStyles>(
    name: 'AppScaffoldProviders.appStyles',
    (ref) => throw Exception(
      'AppScaffoldProviders.appStyles provider needs to be overridden.',
    ),
  );

  static final applicationType = Provider<ApplicationType>(
    name: 'AppScaffoldProviders.applicationType',
    (ref) {
      final settingsApplicationType = ref.watch(ApplicationSettings.applicationType.value);
      final staticApplicationType = ref.read(AppScaffoldProviders.appDefinition).applicationType;
      final applicationType = staticApplicationType ?? settingsApplicationType;
      log.d('New Application Type: $applicationType');
      return applicationType;
    },
  );

  static final router = AppScaffoldRouter.provider;

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
}
