import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_platform/scaffold_app_dsl.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/models/app_styles.dart';
import 'package:wt_app_scaffold/models/definition/info/page_info.dart';
import 'package:wt_app_scaffold/models/scaffold_page_type.dart';
import 'package:wt_logging/wt_logging.dart';
import 'package:wt_provider_manager/wt_provider_manager.dart';

mixin AppScaffoldApp {
  static void runAsPlainApp({
    required Widget appWidget,
    List<Override> includeOverrides = const [],
    Provider<ProviderManager>? providerManager,
    Level setApplicationLogLevel = Level.warning,
    Map<Type, Level> setLogLevels = const {},
    bool devicePreview = false,
    bool enableProviderMonitoring = false,
    double devicePreviewMinimumWidth = 500,
    List<ProviderObserver>? includeObservers,
    Widget? splashWidget,
    double? virtualSize,
    bool enableErrorMonitoring = false,
  }) {
    runMyApp(
      asPlainApp(appWidget),
      setApplicationLogLevel: setApplicationLogLevel,
      setLogLevels: setLogLevels,
      includeOverrides: includeOverrides,
      onReady: (_, __) {},
      enableErrorMonitoring: enableErrorMonitoring,
      providerManager: providerManager,
      devicePreview: devicePreview,
      devicePreviewMinimumWidth: devicePreviewMinimumWidth,
      enableProviderMonitoring: enableProviderMonitoring,
      includeObservers: includeObservers,
      splashWidget: splashWidget,
      virtualSize: virtualSize,
    );
  }

  static void runAppScaffold({
    required AppDefinition Function(ApplicationType, PageDefinition) appDefinitionBuilder,
    required AppDetails appDetails,
    AppStyles Function(Ref ref) appStyles = SharedAppConfig.styles,
    PageDefinition? templatePage,
    List<Override> includeOverrides = const [],
    Level setApplicationLogLevel = Level.warning,
    Map<Type, Level> setLogLevels = const {},
    Provider<ProviderManager>? providerManager,
    ApplicationType? applicationType,
  }) {
    final selectedApplicationType = applicationType ?? ApplicationType.goRouterMenu;

    final pageTemplate = PageDefinition(
      pageInfo: PageInfo(
        name: 'template',
        title: 'Template',
        icon: Icons.abc,
      ),
      // pageBuilder: placeholderScreenBuilder,
      primary: false,
      scaffoldType: ScaffoldPageType.transparentCard,
      showAppBar: selectedApplicationType == ApplicationType.goRouterMenu,
      showBottomMenu: selectedApplicationType == ApplicationType.goRouterMenu,
      registerChildRoutes: selectedApplicationType == ApplicationType.bottomNavBar,
    );

    runMyApp(
      andAppScaffold(
        appDefinition: appDefinitionBuilder(selectedApplicationType, pageTemplate),
        appDetails: appDetails,
        appStyles: appStyles,
      ),
      setApplicationLogLevel: setApplicationLogLevel,
      setLogLevels: setLogLevels,
      includeOverrides: includeOverrides,
      enableErrorMonitoring: true,
      providerManager: providerManager,
    );
  }
}
