import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
import 'package:firebase_ui_oauth_apple/firebase_ui_oauth_apple.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:wt_app_scaffold/app_platform/models/feature_definition.dart';
import 'package:wt_app_scaffold/app_platform/models/provider_override_definition.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/providers/app_scaffolds_providers.dart';
import 'package:wt_app_scaffold/scaffolds/login/config.dart';
import 'package:wt_firepod/wt_firepod.dart' hide EmailAuthProvider, PhoneAuthProvider;
import 'package:wt_logging/wt_logging.dart';

class LoginScreenSupport extends ConsumerWidget {
  static final log = logger(LoginScreenSupport);

  final Widget child;
  final LoginSupport? loginSupport;
  final bool emailVerificationRequired;

  const LoginScreenSupport({
    super.key,
    required this.child,
    this.loginSupport,
    this.emailVerificationRequired = false,
  });

  static Future<Map<ProviderListenable, ProviderOverrideDefinition>> init({
    required FirebaseOptions firebaseOptions,
    required FirebaseApp firebaseApp,
    required LoginSupport? loginSupport,
    required Map<ProviderListenable, ProviderOverrideDefinition> contextMap,
    FeatureDefinition? child,
  }) async {
    if (loginSupport != null) {
      final googleClientId = kIsWeb
          ? firebaseOptions.appId
          : Platform.isAndroid
              ? firebaseOptions.appId
              : firebaseOptions.iosClientId;

      if (googleClientId == null) {
        throw Exception('GOOGLE_CLIENT_ID has not been set.');
      }
      FirebaseUIAuth.configureProviders(
        [
          if (loginSupport.emailEnabled) EmailAuthProvider(),
          if (loginSupport.emailLinkEnabled)
            EmailLinkAuthProvider(
              actionCodeSettings: FirebaseAuthKeys.actionCodeSettings,
            ),
          if (loginSupport.phoneEnabled) PhoneAuthProvider(),
          if (loginSupport.googleEnabled && Platform.isAndroid)
            GoogleProvider(clientId: googleClientId),
          if (loginSupport.appleEnabled) AppleProvider(),
        ],
        app: firebaseApp,
      );
    }
    if (child != null) {
      return child.initialiser(contextMap);
    } else {
      return contextMap;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appDetails = ref.read(AppScaffoldProviders.appDetails);
    final themeMode = ref.watch(ApplicationSettings.theme.value);
    final verifyEmail = ref.watch(ApplicationSettings.verifyEmail.value);
    final auth = ref.watch(FirebaseProviders.auth);
    final color = ref.watch(ApplicationSettings.colorScheme.value);
    final iconPath = appDetails.iconPath;
    final User? currentUser = auth.currentUser;
    final welcomeString = _createWelcomeString(appDetails);

    final initialRoute = currentUser == null
        ? '/sign-in'
        : emailVerificationRequired && !currentUser.emailVerified
            ? '/verify-email'
            : '/';

    final buttonStyle = ButtonStyle(
      padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );

    final snackBarKey = ref.read(UserLog.snackBarKey);
    final navigatorKey = ref.read(AppScaffoldProviders.navigatorKey);

    final mfaAction = AuthStateChangeAction<MFARequired>(
      (context, state) async {
        final nav = Navigator.of(context);

        await startMFAVerification(
          resolver: state.resolver,
          context: context,
        );

        nav.pushReplacementNamed('/profile');
      },
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
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,
      scaffoldMessengerKey: snackBarKey,
      navigatorKey: navigatorKey,
      initialRoute: initialRoute,
      routes: {
        '/sign-in': (context) {
          return SignInScreen(
            auth: auth,
            actions: [
              ForgotPasswordAction((context, email) {
                Navigator.pushNamed(
                  context,
                  '/forgot-password',
                  arguments: {'email': email},
                );
              }),
              VerifyPhoneAction((context, _) {
                Navigator.pushNamed(context, '/phone');
              }),
              AuthStateChangeAction<SignedIn>((context, state) {
                if (!emailVerificationRequired) {
                  Navigator.pushNamed(context, '/');
                } else {
                  if (!state.user!.emailVerified) {
                    log.d('Sending verification email.');
                    auth.currentUser!.sendEmailVerification();
                    Navigator.pushNamed(context, '/verify-email');
                  } else {
                    Navigator.pushReplacementNamed(context, '/profile');
                  }
                }
              }),
              AuthStateChangeAction<UserCreated>((context, state) {
                if (!verifyEmail) {
                  Navigator.pushNamed(context, '/');
                } else {
                  if (!state.credential.user!.emailVerified) {
                    Navigator.pushNamed(context, '/verify-email');
                  } else {
                    Navigator.pushReplacementNamed(context, '/profile');
                  }
                }
              }),
              mfaAction,
              EmailLinkSignInAction((context) {
                Navigator.pushReplacementNamed(context, '/email-link-sign-in');
              }),
            ],
            styles: const {
              EmailFormStyle(
                signInButtonVariant: ButtonVariant.filled,
              ),
            },
            headerBuilder: _headerImage(iconPath),
            sideBuilder: _sideImage(iconPath),
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  action == AuthAction.signIn
                      ? '$welcomeString Please sign in to continue.'
                      : '$welcomeString Please create an account to continue',
                ),
              );
            },
            footerBuilder: (context, action) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Column(
                    children: [],
                  ),
                ),
              );
            },
          );
        },
        '/': (_) => currentUser == null
            ? Container(
                padding: const EdgeInsets.all(20),
                color: Colors.orangeAccent,
                child: Scaffold(body: child),
              )
            : Container(
                padding: const EdgeInsets.all(20),
                color: Colors.green,
                child: Scaffold(body: child),
              )
      },
      title: 'Firebase UI demo',
      locale: const Locale('en'),
      localizationsDelegates: [
        FirebaseUILocalizations.withDefaultOverrides(const _LabelOverrides()),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FirebaseUILocalizations.delegate,
        FormBuilderLocalizations.delegate,
      ],
    );
  }
}

String _createWelcomeString(AppDetails appDetails) {
  final name = appDetails.title.isNotEmpty ? appDetails.title : appDetails.subTitle;

  return name.isEmpty ? 'Welcome!' : 'Welcome to $name!';
}

HeaderBuilder _headerImage(String assetName) {
  return (context, constraints, _) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Image.asset(assetName),
    );
  };
}

// TODO: need to add this back in
// ignore: unused_element
HeaderBuilder _headerIcon(IconData icon) {
  return (context, constraints, shrinkOffset) {
    return Padding(
      padding: const EdgeInsets.all(20).copyWith(top: 40),
      child: Icon(
        icon,
        color: Colors.blue,
        size: constraints.maxWidth / 4 * (1 - shrinkOffset),
      ),
    );
  };
}

SideBuilder _sideImage(String assetName) {
  return (context, constraints) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(constraints.maxWidth / 4),
        child: Image.asset(assetName),
      ),
    );
  };
}

// TODO: need to add this back in
// ignore: unused_element
SideBuilder _sideIcon(IconData icon) {
  return (context, constraints) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Icon(
        icon,
        color: Colors.blue,
        size: constraints.maxWidth / 3,
      ),
    );
  };
}

class _LabelOverrides extends DefaultLocalizations {
  const _LabelOverrides();

  @override
  String get emailInputLabel => 'Enter your email';
}
