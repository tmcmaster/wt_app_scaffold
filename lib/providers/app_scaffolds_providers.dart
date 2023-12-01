import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_platform/util/app_scaffold_router.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/models/app_styles.dart';

mixin AppScaffoldProviders {
  static final appDefinition = Provider<AppDefinition>(
    name: 'AppScaffoldProviders.appAppDefinition',
    (ref) => throw Exception(
      'AppScaffoldProviders.appAppDefinition provider needs to be overridden.',
    ),
  );

  static final appPages = Provider(
    name: 'AppScaffoldProviders.appPages',
    (ref) {
      final pages = ref.read(appDefinition).pages;
      final debugMode = ref.watch(ApplicationSettings.debugMode.value);
      return pages.where((page) => debugMode || !page.debug).toList()
        ..sort(
          (a, b) => a.primary && !b.primary
              ? -1
              : b.primary && !a.primary
                  ? 1
                  : 0,
        );
    },
  );

  static final appPrimaryPages = Provider(
    name: 'AppScaffoldProviders.appPrimaryPages',
    (ref) {
      return ref.watch(appPages).where((page) => page.primary).toList();
    },
  );

  static final appSecondaryPages = Provider(
    name: 'AppScaffoldProviders.appSecondaryPages',
    (ref) {
      return ref.watch(appPages).where((page) => !page.primary).toList();
    },
  );

  static final appInitialPageIndex = Provider(
    name: 'AppScaffoldProviders.appInitialPageIndex',
    (ref) {
      final pages = ref.watch(appPages);
      final landingPages = pages.where((page) => page.landing);
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
      final applicationDefinition =
          ref.read(AppScaffoldProviders.appDefinition);
      final settingsApplicationType =
          ref.watch(ApplicationSettings.applicationType.value);
      final staticApplicationType = applicationDefinition.applicationType;
      final applicationType = staticApplicationType ?? settingsApplicationType;
      return applicationType;
    },
  );

  static final router = Provider(
    name: 'AppScaffoldProviders.router',
    (ref) => AppScaffoldRouter(ref),
  );
}
