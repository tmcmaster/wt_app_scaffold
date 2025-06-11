import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_definition/app_definition.dart';
import 'package:wt_app_scaffold/app_platform/scaffold_app_dsl.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_logging/wt_logging.dart';
import 'package:wt_provider_manager/provider_manager.dart';

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
    required AppDefinition appDefinition,
    AppStyles Function(Ref ref) appStyles = SharedAppConfig.styles,
    List<Override> includeOverrides = const [],
    Level setApplicationLogLevel = Level.warning,
    Map<Type, Level> setLogLevels = const {},
    Provider<ProviderManager>? providerManager,
    ApplicationType? applicationType,
  }) {
    runMyApp(
      andAppScaffold(
        appDefinition: appDefinition,
        appStyles: appStyles,
        applicationType: applicationType,
      ),
      setApplicationLogLevel: setApplicationLogLevel,
      setLogLevels: setLogLevels,
      includeOverrides: includeOverrides,
      enableErrorMonitoring: true,
      providerManager: providerManager,
    );
  }
}
