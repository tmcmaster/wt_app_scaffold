import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_platform.dart';
import 'package:wt_app_scaffold/app_platform/future_provider_scope.dart';
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureProviderScope(
      init: (ref) async {
        return [
          AppScaffoldProviders.appDefinition.overrideWith((ref) => ref.read(appDefinition)),
          AppScaffoldProviders.appDetails.overrideWith((ref) => ref.read(appDetails)),
        ];
      },
      child: const _ApplicationMaterialApp(),
    );
  }
}

class _ApplicationMaterialApp extends ConsumerWidget {
  const _ApplicationMaterialApp();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appDefinition = ref.read(AppScaffoldProviders.appDefinition);
    final themeMode = ref.watch(ApplicationSettings.theme.value);
    final debugMode = ref.watch(ApplicationSettings.debugMode.value);
    final color = ref.watch(ApplicationSettings.colorScheme.value);

    final isLoginEnabled = context.findAncestorWidgetOfExactType<LoginScreenSupport>() != null;
    print('LOGIN SUPPORT: $isLoginEnabled');

    final snackBarKey = isLoginEnabled ? null : ref.read(UserLog.snackBarKey);
    final navigatorKey = isLoginEnabled ? null : ref.read(AppScaffoldProviders.navigatorKey);

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
      home: AppBuilder(appDefinition: appDefinition),
    );
  }
}
