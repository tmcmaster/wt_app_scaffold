import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:wt_action_button/utils/logging.dart';
import 'package:wt_app_scaffold/models/app_definition.dart';
import 'package:wt_app_scaffold/providers/app_scaffolds_providers.dart';
import 'package:wt_app_scaffold/scaffolds/app/app_builder.dart';
import 'package:wt_app_scaffold/scaffolds/app/application_settings.dart';
import 'package:wt_firepod/wt_firepod.dart';

import 'config.dart';

class LoginAppContainer extends ConsumerWidget {
  static final GlobalKey<ScaffoldMessengerState> snackBarKey =
      GlobalKey<ScaffoldMessengerState>();
  static final log = logger(LoginAppContainer);

  final bool emailVerificationRequired;

  final AlwaysAliveProviderBase<AppDefinition> appDefinition;

  const LoginAppContainer({
    super.key,
    required this.appDefinition,
    this.emailVerificationRequired = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final iconPath = ref.read(appDefinition).appDetails?.iconPath ??
        'assets/images/avocado.png';
    final themeMode = ref.watch(ApplicationSettings.theme.value);
    final debugMode = ref.watch(ApplicationSettings.debugMode.value);
    final verifyEmail = ref.watch(ApplicationSettings.verifyEmail.value);
    final auth = ref.watch(FirebaseProviders.auth);
    final color = ref.watch(ApplicationSettings.colorScheme.value);
    final User? currentUser = auth.currentUser;
    log.d('LoginAppContainer: user(${currentUser?.email})');
    final initialRoute = currentUser == null
        ? '/'
        : emailVerificationRequired && !currentUser.emailVerified
            ? '/verify-email'
            : '/welcome';

    final buttonStyle = ButtonStyle(
      padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );

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
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,
      scaffoldMessengerKey: snackBarKey,
      navigatorKey: ref.read(AppScaffoldProviders.navigatorKey),
      initialRoute: initialRoute,
      routes: {
        '/': (context) {
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
                  Navigator.pushNamed(context, '/welcome');
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
                  Navigator.pushNamed(context, '/welcome');
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
                      ? 'Welcome to Firebase UI! Please sign in to continue.'
                      : 'Welcome to Firebase UI! Please create an account to continue',
                ),
              );
            },
            footerBuilder: (context, action) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Column(
                    children: [],
                  ),
                ),
              );
            },
          );
        },
        '/verify-email': (context) {
          return EmailVerificationScreen(
            auth: auth,
            headerBuilder: _headerIcon(Icons.verified),
            sideBuilder: _sideIcon(Icons.verified),
            actionCodeSettings: FirebaseAuthKeys.actionCodeSettings,
            actions: [
              EmailVerifiedAction(() {
                log.d('Sending verification email.');
                auth.currentUser!.sendEmailVerification();
                Navigator.pushReplacementNamed(context, '/profile');
              }),
              AuthCancelledAction((context) {
                FirebaseUIAuth.signOut(context: context);
                Navigator.pushReplacementNamed(context, '/');
              }),
            ],
          );
        },
        '/phone': (context) {
          return PhoneInputScreen(
            auth: auth,
            actions: [
              SMSCodeRequestedAction((context, action, flowKey, phone) {
                Navigator.of(context).pushReplacementNamed(
                  '/sms',
                  arguments: {
                    'action': action,
                    'flowKey': flowKey,
                    'phone': phone,
                  },
                );
              }),
            ],
            headerBuilder: _headerIcon(Icons.phone),
            sideBuilder: _sideIcon(Icons.phone),
          );
        },
        '/sms': (context) {
          final arguments = ModalRoute.of(context)?.settings.arguments
              as Map<String, dynamic>?;

          return SMSCodeInputScreen(
            auth: auth,
            actions: [
              AuthStateChangeAction<SignedIn>((context, state) {
                Navigator.of(context).pushReplacementNamed('/profile');
              })
            ],
            flowKey: arguments?['flowKey'],
            action: arguments?['action'],
            headerBuilder: _headerIcon(Icons.sms_outlined),
            sideBuilder: _sideIcon(Icons.sms_outlined),
          );
        },
        '/forgot-password': (context) {
          final arguments = ModalRoute.of(context)?.settings.arguments
              as Map<String, dynamic>?;

          return ForgotPasswordScreen(
            auth: auth,
            email: arguments?['email'],
            headerMaxExtent: 200,
            headerBuilder: _headerIcon(Icons.lock),
            sideBuilder: _sideIcon(Icons.lock),
          );
        },
        '/email-link-sign-in': (context) {
          return EmailLinkSignInScreen(
            auth: auth,
            actions: [
              AuthStateChangeAction<SignedIn>((context, state) {
                Navigator.pushReplacementNamed(context, '/');
              }),
            ],
            provider: EmailLinkAuthProvider(
              actionCodeSettings: FirebaseAuthKeys.actionCodeSettings,
            ),
            headerMaxExtent: 200,
            headerBuilder: _headerIcon(Icons.link),
            sideBuilder: _sideIcon(Icons.link),
          );
        },
        '/profile': (context) {
          return ProfileScreen(
            auth: auth,
            actions: [
              SignedOutAction((context) {
                Navigator.pushReplacementNamed(context, '/');
              }),
              mfaAction,
            ],
            actionCodeSettings: FirebaseAuthKeys.actionCodeSettings,
            showMFATile: true,
          );
        },
        '/welcome': (context) => AppBuilder(
              appDefinition: ref.read(appDefinition),
            ),
      },
      title: 'Firebase UI demo',
      debugShowCheckedModeBanner: debugMode,
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

class _LabelOverrides extends DefaultLocalizations {
  const _LabelOverrides();

  @override
  String get emailInputLabel => 'Enter your email';
}

HeaderBuilder _headerImage(String assetName) {
  return (context, constraints, _) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Image.asset(assetName),
    );
  };
}

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
