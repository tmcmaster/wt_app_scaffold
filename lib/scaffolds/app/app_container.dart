import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_platform/providers/app_platform_providers.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/providers/app_scaffolds_providers.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_logging/wt_logging.dart';

class AppContainer extends ConsumerWidget {
  static final log = logger(AppContainer);

  static final GlobalKey<ScaffoldMessengerState> snackBarKey =
      GlobalKey<ScaffoldMessengerState>();

  const AppContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appDefinition = ref.read(AppScaffoldProviders.appDefinition);
    final themeMode = ref.watch(ApplicationSettings.theme.value);
    final color = ref.watch(ApplicationSettings.colorScheme.value);
    final debugMode = ref.watch(ApplicationSettings.debugMode.value);

    final user = ref.watch(FirebaseProviders.auth).currentUser;
    final initialRoute =
        user == null ? LoginView.routeName : AppBuilder.routeName;

    ref.read(AppPlatformProviders.providerManager);

    return MaterialApp(
      title: appDefinition.appTitle,
      debugShowCheckedModeBanner: debugMode,
      restorationScopeId: appDefinition.appName,
      scaffoldMessengerKey: snackBarKey,
      navigatorKey: ref.read(AppPlatformProviders.navigatorKey),
      localizationsDelegates: [
        ...appDefinition.localizationDelegates ?? [],
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
      ],
      theme: ThemeData(
        primarySwatch: color,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,
      initialRoute: initialRoute,
      routes: {
        LoginView.routeName: (context) => LoginView(
              firebaseLogin: ref.read(FirebaseProviders.authNotifier),
              landingRoute: AppBuilder.routeName,
            ),
        LinkEmailSignInView.routeName: (context) => LinkEmailSignInView(
              firebaseLogin: ref.read(FirebaseProviders.authNotifier),
              landingRoute: AppBuilder.routeName,
            ),
        AppBuilder.routeName: (context) => const AppBuilder(),
      },
    );
  }
}
