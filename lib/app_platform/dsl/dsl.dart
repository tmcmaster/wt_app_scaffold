import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_platform/components/provider_monitor.dart';
import 'package:wt_app_scaffold/app_platform/models/feature_definition.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/models/app_styles.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_logging/wt_logging.dart';

Future<void> runMyApp(
  FeatureDefinition child, {
  List<ProviderObserver> includeObservers = const [],
  List<Override> includeOverrides = const [],
  bool enableProviderMonitoring = false,
  Level setApplicationLogLevel = Level.info,
  bool enableErrorMonitoring = false,
  bool devicePreview = false,
  double? virtualSize,
  void Function(BuildContext, WidgetRef)? onReady,
}) async {
  final log = logger('RunMy App');

  final contextMap = await AppPlatform.init(
    setApplicationLogLevel: setApplicationLogLevel,
    enableErrorMonitoring: enableErrorMonitoring,
  );
  runApp(
    ProviderScope(
      overrides: (await child.initialiser(contextMap))
          .values
          .map((e) => e.override)
          .toList(),
      observers: [
        if (enableProviderMonitoring) ProviderMonitor.instance,
      ],
      child: Consumer(
        builder: (context, ref, _) {
          try {
            onReady?.call(context, ref);
          } catch (error) {
            log.e('onReady experienced an error: $error');
          }
          return AppPlatform(
            includeOverrides: includeOverrides,
            includeObservers: includeObservers,
            enableProviderMonitoring: enableProviderMonitoring,
            virtualSize: virtualSize,
            devicePreview: devicePreview,
            child: child.builder(ref),
          );
        },
      ),
    ),
  );
}

FeatureDefinition asPlainApp(
  Widget child,
) {
  return FeatureDefinition(
    initialiser: (contextMap) async {
      return contextMap;
    },
    builder: (ref) {
      return child;
    },
  );
}

const andFirebase = withFirebase;

FeatureDefinition withFirebase(
  FeatureDefinition child, {
  required String appName,
  required FirebaseOptions firebaseOptions,
  bool crashlytics = false,
  bool database = false,
  bool firestore = false,
  bool storage = false,
  bool functions = false,
}) {
  return FeatureDefinition(
    initialiser: (contextMap) => FirebaseSupport.init(
      appName: appName,
      firebaseOptions: firebaseOptions,
      child: child,
      contextMap: contextMap,
      crashlytics: crashlytics,
      database: database,
      firestore: firestore,
      storage: storage,
      functions: functions,
    ),
    builder: (ref) => FirebaseSupport(
      appName: appName,
      firebaseOptions: firebaseOptions,
      child: child.builder(ref),
    ),
  );
}

const andLogin = withLogin;

FeatureDefinition withLogin(
  FeatureDefinition child, {
  LoginSupport loginSupport = LoginSupport.none,
}) {
  return FeatureDefinition(
    initialiser: (contextMap) async {
      if (contextMap.containsKey(FirebaseProviders.firebaseOptions) &&
          contextMap.containsKey(FirebaseProviders.app)) {
        final firebaseOptions = contextMap[FirebaseProviders.firebaseOptions]!
            .value as FirebaseOptions;
        final firebaseApp =
            contextMap[FirebaseProviders.app]!.value as FirebaseApp;
        return LoginScreenSupport.init(
          firebaseOptions: firebaseOptions,
          firebaseApp: firebaseApp,
          loginSupport: loginSupport,
          child: child,
          contextMap: contextMap,
        );
      }
      throw Exception('Login does not have the providers it requires: '
          'FirebaseOptions(${contextMap.containsKey(FirebaseProviders.firebaseOptions)}), '
          'FirebaseApp(${contextMap.containsKey(FirebaseProviders.app)})');
    },
    builder: (ref) => LoginScreenSupport(
      loginSupport: loginSupport,
      child: child.builder(ref),
    ),
  );
}

const andAppScaffold = withAppScaffold;

FeatureDefinition withAppScaffold({
  required AlwaysAliveProviderBase<AppDefinition> appDefinition,
  required AlwaysAliveProviderBase<AppDetails> appDetails,
  required AlwaysAliveProviderBase<AppStyles> appStyles,
  double? virtualSize,
}) {
  return FeatureDefinition(
    initialiser: (contextMap) => AppScaffoldSupport.init(
      appDetails: appDetails,
      appDefinition: appDefinition,
      appStyles: appStyles,
      contextMap: contextMap,
    ),
    builder: (ref) => AppScaffoldSupport(
      appDetails: appDetails,
      appDefinition: appDefinition,
    ),
  );
}
