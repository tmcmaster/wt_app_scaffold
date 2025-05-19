import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_platform/features/app_scaffold_application_feature.dart';
import 'package:wt_app_scaffold/app_platform/features/app_scaffold_login_feature.dart';
import 'package:wt_app_scaffold/app_platform/features/app_scaffold_plain_app_feature.dart';
import 'package:wt_app_scaffold/app_platform/features/app_scaffold_platform_feature.dart';
import 'package:wt_app_scaffold/app_platform/model/app_scaffold_context_builder.dart';
import 'package:wt_app_scaffold/app_platform/model/app_scaffold_context_map.dart';
import 'package:wt_app_scaffold/app_platform/model/app_scaffold_feature_definition.dart';
import 'package:wt_app_scaffold/app_platform/model/app_scaffold_widget_builder.dart';
import 'package:wt_app_scaffold/app_platform/util/app_scaffold_provider_monitor.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/models/app_styles.dart';
import 'package:wt_logging/wt_logging.dart';

bool _hasRun = false;

Future<AppScaffoldContextMap> waitThenBuildHold(
  List<Future> waitFor,
  AppScaffoldContextBuilder builder,
) async {
  await Future.wait(waitFor);
  return builder({});
}

Future<Widget> waitThenBuild(
  List<Provider<Future>> waitFor,
  AppScaffoldWidgetBuilder builder,
  WidgetRef ref,
) async {
  await Future.wait(waitFor.map((p) => ref.read(p)).toList());
  return Builder(builder: (context) => builder(context, ref));
}

// handles the splash screen and provider scope
Future<void> runMyApp(
  AppScaffoldFeatureDefinition featureDefinition, {
  bool devicePreview = false,
  double? devicePreviewMinimumWidth = 500,
  double? virtualSize,
  bool enableProviderMonitoring = false,
  bool enableErrorMonitoring = false,
  Level setApplicationLogLevel = Level.warning,
  void Function(BuildContext, WidgetRef)? onReady,
  List<ProviderObserver>? includeObservers,
  List<Override>? includeOverrides,
  Widget? splashWidget,
  List<ProviderBase> preloadProviders = const [],
  List<Provider<Future>> waitFor = const [],
}) async {
  // ensure the app only run once.
  if (_hasRun) {
    debugPrint('‼️ Application has already been started  ‼️');
    return;
  } else {
    debugPrint('✅ Starting the Application  ✅');
    _hasRun = true;
  }

  WidgetsFlutterBinding.ensureInitialized();
  final log = logger('RunMyApp', level: Level.debug);

  // if (kReleaseMode) {
  //   await LogToFile.initialise();
  //   LogToFile.log.i('Logging to file.');
  // } else if (kDebugMode) {
  //   log.i('Logging to the console.');
  //   LogToFile.log.i('Logging to file.');
  // } else if (kProfileMode) {
  //   LogToFile.log.i('Logging to console.');
  // }

  final platformDefinition = AppScaffoldPlatformFeature(
    featureDefinition,
    devicePreview: devicePreview,
    devicePreviewMinimumWidth: devicePreviewMinimumWidth,
    onReady: onReady,
    enableErrorMonitoring: enableErrorMonitoring,
    setApplicationLogLevel: setApplicationLogLevel,
    virtualSize: virtualSize,
  );

  runApp(
    FutureBuilder(
      future: platformDefinition.contextBuilder({}),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
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
                for (final provider in preloadProviders) {
                  ref.read(provider);
                }
                return FutureBuilder(
                    future: waitThenBuild(waitFor, platformDefinition.widgetBuilder, ref),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                        debugPrint('✅ All providers have been loaded  ✅');
                        return snapshot.data!;
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.green,
                          ),
                        );
                      }
                    });
              },
            ),
          );
        } else {
          log.d('===> PROGRESS MaterialApp');
          final title = snapshot.data == null ? 'Progress Indicator' : snapshot.data!.runtimeType.toString();
          return MaterialApp(
            title: 'Login Feature : $title',
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: splashWidget ?? const CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    ),
  );
}

// AppScaffoldApplicationFeature? findAppScaffoldApplicationFeature(AppScaffoldFeatureDefinition featureDefinition) {
//   if (featureDefinition is AppScaffoldApplicationFeature) {
//     return featureDefinition;
//   } else if (featureDefinition.childFeature != null) {
//     return findAppScaffoldApplicationFeature(featureDefinition.childFeature!);
//   } else {
//     return null;
//   }
// }

const andAppScaffold = withAppScaffold;

typedef ProviderBuilder<T> = T Function(Ref ref);

AppScaffoldFeatureDefinition withAppScaffold({
  required AppDetails appDetails,
  required AppDefinition appDefinition,
  required ProviderBuilder<AppStyles> appStyles,
}) {
  return AppScaffoldApplicationFeature(
    null,
    appDetails: appDetails,
    appDefinition: appDefinition,
    appStyles: appStyles,
  );
}

const andAuthentication = withAuthentication;

AppScaffoldFeatureDefinition withAuthentication(
  AppScaffoldFeatureDefinition featureDefinition, {
  Widget? splashWidget,
}) {
  return AppScaffoldLoginFeature(
    featureDefinition,
    splashWidget: splashWidget,
  );
}

AppScaffoldFeatureDefinition asPlainApp(
  Widget child,
) {
  return AppScaffoldPlainAppFeature(child);
}
