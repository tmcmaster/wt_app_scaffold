import 'package:firepod/auth/auth.dart';
import 'package:firepod/auth/link_email_sign_in_view.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/providers/app_scaffolds_providers.dart';

class AppContainer extends ConsumerWidget {
  static final log = logger(AppContainer);

  static final GlobalKey<ScaffoldMessengerState> snackBarKey = GlobalKey<ScaffoldMessengerState>();

  final AppDefinition appDefinition;

  const AppContainer({
    super.key,
    required this.appDefinition,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(ApplicationSettings.theme.value);
    final color = ref.watch(ApplicationSettings.colorScheme.value);
    final debugMode = ref.watch(ApplicationSettings.debugMode.value);

    final user = ref.watch(FirebaseSetup.instance.login);
    final initialRoute = user == UserAuth.none ? LoginPage.routeName : AppBuilder.routeName;

    ref.read(AppScaffoldProviders.providerManager);

    return MaterialApp(
      title: appDefinition.appTitle,
      debugShowCheckedModeBanner: debugMode,
      restorationScopeId: appDefinition.appName,
      scaffoldMessengerKey: snackBarKey,
      navigatorKey: ref.read(AppScaffoldProviders.navigatorKey),
      localizationsDelegates: [
        ...(appDefinition.localizationDelegates ?? []),
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
        LoginPage.routeName: (context) => LoginPage(
              firebaseLogin: ref.read(FirebaseSetup.instance.login.notifier),
              landingRoute: AppBuilder.routeName,
            ),
        LinkEmailSignInView.routeName: (context) => LinkEmailSignInView(
              firebaseLogin: ref.read(FirebaseSetup.instance.login.notifier),
              landingRoute: AppBuilder.routeName,
            ),
        AppBuilder.routeName: (context) => AppBuilder(
              appDefinition: appDefinition,
            ),
      },
    );
  }
}
