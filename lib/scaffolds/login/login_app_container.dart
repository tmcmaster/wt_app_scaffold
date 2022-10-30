import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
import 'package:firepod/auth/auth.dart';
import 'package:firepod/firebase_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/scaffolds/app/application_settings.dart';

import 'config.dart';

class LoginAppContainer extends ConsumerWidget {
  final AppDefinition appDefinition;

  LoginAppContainer({
    super.key,
    required this.appDefinition,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final debugMode = ref.watch(ApplicationSettings.debugMode.value);
    final auth = ref.watch(FirebaseProviders.auth);
    final User? currentUser = auth.currentUser;
    print('LoginAppContainer: user(${currentUser?.email})');
    final initialRoute = currentUser == null
        ? '/'
        : !currentUser.emailVerified && currentUser.email != null && false // TODO: need to remove debug false
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
        brightness: Brightness.light,
        visualDensity: VisualDensity.standard,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(style: buttonStyle),
        textButtonTheme: TextButtonThemeData(style: buttonStyle),
        outlinedButtonTheme: OutlinedButtonThemeData(style: buttonStyle),
      ),
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
                if (!state.user!.emailVerified) {
                  print('Sending verification email.');
                  auth.currentUser!.sendEmailVerification();
                  Navigator.pushNamed(context, '/verify-email');
                } else {
                  Navigator.pushReplacementNamed(context, '/profile');
                }
              }),
              AuthStateChangeAction<UserCreated>((context, state) {
                if (!state.credential.user!.emailVerified) {
                  Navigator.pushNamed(context, '/verify-email');
                } else {
                  Navigator.pushReplacementNamed(context, '/profile');
                }
              }),
              mfaAction,
              EmailLinkSignInAction((context) {
                Navigator.pushReplacementNamed(context, '/email-link-sign-in');
              }),
            ],
            styles: const {
              EmailFormStyle(signInButtonVariant: ButtonVariant.filled),
            },
            headerBuilder: _headerImage('assets/avocado.png'),
            sideBuilder: _sideImage('assets/avocado.png'),
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
                  child: Text(
                    action == AuthAction.signIn
                        ? 'By signing in, you agree to our terms and conditions.'
                        : 'By registering, you agree to our terms and conditions.',
                    style: const TextStyle(color: Colors.grey),
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
            actionCodeSettings: actionCodeSettings,
            actions: [
              EmailVerifiedAction(() {
                print('Sending verification email.');
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
          final arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

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
          final arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

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
              actionCodeSettings: actionCodeSettings,
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
            actionCodeSettings: actionCodeSettings,
            showMFATile: true,
          );
        },
        '/welcome': (context) => AppBuilder(
              appDefinition: appDefinition,
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
