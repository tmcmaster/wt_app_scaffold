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
import 'package:wt_provider_manager/wt_provider_manager.dart';

bool _hasRun = false;

typedef ProviderBuilder<T> = T Function(Ref ref);

Future<AppScaffoldContextMap> waitThenBuildHold(
  List<Future> waitFor,
  AppScaffoldContextBuilder builder,
) async {
  await Future.wait(waitFor);
  return builder({});
}

Future<void> runMyApp(
  AppScaffoldFeatureDefinition featureDefinition, {
  bool devicePreview = false,
  double? devicePreviewMinimumWidth = 500,
  double? virtualSize,
  bool enableProviderMonitoring = false,
  bool enableErrorMonitoring = false,
  Level setApplicationLogLevel = Level.warning,
  Map<Type, Level> setLogLevels = const {},
  void Function(BuildContext, WidgetRef)? onReady,
  List<ProviderObserver>? includeObservers,
  List<Override>? includeOverrides,
  Widget? splashWidget,
  Provider<ProviderManager>? providerManager,
}) async {
  logLevelMap.addAll(setLogLevels);
  final log = logger('RunMyApp', level: setApplicationLogLevel);

  if (_hasRun) {
    log.w('⚠️ Application has already been started ⚠️');
    return;
  } else {
    log.i('✅ Starting the Application  ✅');
    _hasRun = true;
  }

  WidgetsFlutterBinding.ensureInitialized();

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
                Future<Widget> waitThenBuild(
                  ProviderBase<ProviderManager> providerManager,
                  AppScaffoldWidgetBuilder builder,
                ) async {
                  final futureProvider = ProviderManager.createInitialisationProvider(providerManager);
                  log.i('🐹Provider manager to complete: ${providerManager.name}');
                  await ref.read(futureProvider);
                  log.i('🐹Provider manager has completed: ${providerManager.name}');
                  return Builder(builder: (context) => builder(context, ref));
                }

                return providerManager == null
                    ? platformDefinition.widgetBuilder(context, ref)
                    : FutureBuilder(
                        future: waitThenBuild(providerManager, platformDefinition.widgetBuilder),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                            log.i('✅ All providers have been loaded  ✅');
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

const andAppScaffold = withAppScaffold;

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
