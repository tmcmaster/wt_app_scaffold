import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_platform/models/feature_definition.dart';
import 'package:wt_app_scaffold/app_platform/models/provider_override_definition.dart';
import 'package:wt_app_scaffold/app_platform/providers/app_platform_providers.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/providers/app_scaffolds_providers.dart';
import 'package:wt_logging/wt_logging.dart';

class AppScaffoldSupport extends ConsumerWidget {
  static final log = logger(AppScaffoldSupport);

  final ProviderListenable<AppDetails> appDetails;
  final ProviderListenable<AppDefinition> appDefinition;

  const AppScaffoldSupport({
    super.key,
    required this.appDetails,
    required this.appDefinition,
  });

  static Future<Map<ProviderListenable, ProviderOverrideDefinition>> init({
    required ProviderListenable<AppDetails> appDetails,
    required ProviderListenable<AppDefinition> appDefinition,
    required Map<ProviderListenable, ProviderOverrideDefinition> contextMap,
    FeatureDefinition? child,
  }) async {
    final newContextMap = {
      ...contextMap,
      AppScaffoldProviders.appDefinition: ProviderOverrideDefinition(
        value: appDefinition,
        override: AppScaffoldProviders.appDefinition.overrideWith((ref) => ref.read(appDefinition)),
      ),
      AppPlatformProviders.appDetails: ProviderOverrideDefinition(
        value: appDetails,
        override: AppPlatformProviders.appDetails.overrideWith((ref) => ref.read(appDetails)),
      ),
    };
    if (child != null) {
      return child.initialiser(newContextMap);
    } else {
      return newContextMap;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(ApplicationSettings.theme.value);
    final debugMode = ref.watch(ApplicationSettings.debugMode.value);
    final color = ref.watch(ApplicationSettings.colorScheme.value);

    final isLoginEnabled = context.findAncestorWidgetOfExactType<LoginScreenSupport>() != null;
    log.d('LOGIN SUPPORT: $isLoginEnabled');

    final snackBarKey = isLoginEnabled ? null : ref.read(UserLog.snackBarKey);
    final navigatorKey = isLoginEnabled ? null : ref.read(AppPlatformProviders.navigatorKey);

    final buttonStyle = ButtonStyle(
      padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: color,
        brightness: Brightness.light,
        visualDensity: VisualDensity.standard,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(style: buttonStyle),
        textButtonTheme: TextButtonThemeData(style: buttonStyle),
        outlinedButtonTheme: OutlinedButtonThemeData(style: buttonStyle),
      ),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,
      debugShowCheckedModeBanner: debugMode,
      scaffoldMessengerKey: snackBarKey,
      navigatorKey: navigatorKey,
      home: const AppBuilder(),
    );
  }
}
