import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:wt_app_scaffold/app_platform/features/app_scaffold_application_feature.dart';
import 'package:wt_app_scaffold/app_platform/features/app_scaffold_login_feature.dart';
import 'package:wt_app_scaffold/app_platform/features/app_scaffold_plain_app_feature.dart';
import 'package:wt_app_scaffold/app_platform/features/app_scaffold_platform_feature.dart';
import 'package:wt_app_scaffold/app_platform/model/app_scaffold_feature_definition.dart';
import 'package:wt_app_scaffold/app_platform/util/app_scaffold_provider_monitor.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/models/app_styles.dart';

// handles the splash screen and provider scope
Future<void> runMyApp(
  AppScaffoldFeatureDefinition featureDefinition, {
  bool devicePreview = false,
  double? virtualSize,
  bool enableProviderMonitoring = false,
  bool enableErrorMonitoring = false,
  Level setApplicationLogLevel = Level.warning,
  void Function(BuildContext, WidgetRef)? onReady,
  List<ProviderObserver>? includeObservers,
  List<Override>? includeOverrides,
}) async {
  final platformDefinition = AppScaffoldPlatformFeature(
    featureDefinition,
    devicePreview: devicePreview,
    onReady: onReady,
    enableErrorMonitoring: enableErrorMonitoring,
    setApplicationLogLevel: setApplicationLogLevel,
    virtualSize: virtualSize,
  );

  runApp(
    FutureBuilder(
      future: platformDefinition.contextBuilder({}),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          final contextMap = snapshot.data!;
          return ProviderScope(
            overrides: [
              ...contextMap.values.map((definition) => definition.override),
              if (includeOverrides != null) ...includeOverrides,
            ],
            observers: [
              if (includeObservers != null) ...includeObservers,
              if (enableProviderMonitoring) AppScaffoldProviderMonitor.instance,
            ],
            child: Consumer(
              builder: (context, ref, _) {
                return featureDefinition.widgetBuilder(context, ref);
              },
            ),
          );
        } else {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    ),
  );
}

const andAppScaffold = withAppScaffold;

AppScaffoldFeatureDefinition withAppScaffold({
  required AppDetails appDetails,
  required AppDefinition appDefinition,
  required AppStyles appStyles,
  ApplicationType? applicationType,
}) {
  return AppScaffoldApplicationFeature(
    null,
    appDetails: appDetails,
    appDefinition: appDefinition,
    appStyles: appStyles,
    applicationType: applicationType,
  );
}

const andAuthentication = withAuthentication;

AppScaffoldFeatureDefinition withAuthentication(
  AppScaffoldFeatureDefinition featureDefinition,
) {
  return AppScaffoldLoginFeature(
    featureDefinition,
  );
}

AppScaffoldFeatureDefinition asPlainApp(
  Widget child,
) {
  return AppScaffoldPlainAppFeature(child);
}