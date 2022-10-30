import 'dart:io';

import 'package:firepod/firepod.dart';
import 'package:flutter/foundation.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';

import '../scaffolds/login/config.dart';

Future<ProviderScope> Function(
  FirebaseApp app,
  FirebaseOptions firebaseOptions,
)
    Function(
  AppDefinition appDefinition,
) withAppScaffold = andAppScaffold;

Future<ProviderScope> Function(
  FirebaseApp app,
  FirebaseOptions firebaseOptions,
) andAppScaffold(
  AppDefinition appDefinition,
) {
  return (app, firebaseOptions) async {
    WidgetsFlutterBinding.ensureInitialized();
    final googleClientId = kIsWeb
        ? firebaseOptions.appId
        : Platform.isAndroid
            ? firebaseOptions.androidClientId
            : firebaseOptions.iosClientId;

    if (googleClientId == null) {
      throw Exception('GOOGLE_CLIENT_ID has not been set.');
    }

    final login = appDefinition.loginSupport;

    FirebaseUIAuth.configureProviders(
      [
        if (login.emailEnabled) EmailAuthProvider(),
        if (login.emailLinkEnabled)
          EmailLinkAuthProvider(
            actionCodeSettings: FirebaseAuthKeys.actionCodeSettings,
          ),
        if (login.phoneEnabled) PhoneAuthProvider(),
        if (login.googleEnabled) GoogleProvider(clientId: googleClientId),
        if (login.appleEnabled) AppleProvider(),
        if (login.twitterEnabled) FacebookProvider(clientId: FirebaseAuthKeys.facebookClientId),
        if (login.twitterEnabled)
          TwitterProvider(
            apiKey: FirebaseAuthKeys.twitterApiKey,
            apiSecretKey: FirebaseAuthKeys.twitterApiSecretKey,
            redirectUri: FirebaseAuthKeys.twitterRedirectURi,
          ),
      ],
      app: app,
    );

    return ProviderScope(
      overrides: const [],
      observers: const [],
      child: LoginAppContainer(
        appDefinition: appDefinition,
      ),
    );
  };
}

void runMyApp(
  Future<dynamic> Function() childBuilder,
) async {
  WidgetsFlutterBinding.ensureInitialized();
  final widget = await child2widget(childBuilder());
  runApp(
    ProviderScope(
      observers: widget is ProviderScope ? widget.observers : null,
      overrides: widget is ProviderScope ? widget.overrides : [],
      child: widget is ProviderScope ? widget.child : widget,
    ),
  );
}

Future<Widget> child2widget(dynamic child) async {
  return child is Future<Widget> ? await child : child;
}
