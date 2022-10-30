import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firepod/firepod.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
    final appName = app.name;
    print('AppScaffold Initialising');
    WidgetsFlutterBinding.ensureInitialized();
    print('FirebaseUIAuth.configureProviders: name($appName)');
    final googleClientId = kIsWeb
        ? firebaseOptions.appId
        : Platform.isAndroid
            ? firebaseOptions.androidClientId
            : firebaseOptions.iosClientId;
    print('GOOGLE_CLIENT_ID = $googleClientId');

    if (googleClientId == null) {
      throw Exception('GOOGLE_CLIENT_ID has not been set.');
    }

    final login = appDefinition.loginSupport;

    FirebaseUIAuth.configureProviders(
      [
        if (login.emailEnabled) EmailAuthProvider(),
        if (login.emailLinkEnabled)
          EmailLinkAuthProvider(
            actionCodeSettings: actionCodeSettings,
          ),
        if (login.phoneEnabled) PhoneAuthProvider(),
        if (login.googleEnabled) GoogleProvider(clientId: googleClientId),
        if (login.appleEnabled) AppleProvider(),
        if (login.twitterEnabled) FacebookProvider(clientId: FACEBOOK_CLIENT_ID),
        if (login.twitterEnabled)
          TwitterProvider(
            apiKey: TWITTER_API_KEY,
            apiSecretKey: TWITTER_API_SECRET_KEY,
            redirectUri: TWITTER_REDIRECT_URI,
          ),
      ],
      app: app,
    );

    print('AppScaffold Returning Scope');
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
  print('MyApp Initialising');
  WidgetsFlutterBinding.ensureInitialized();
  print('MyApp Building Child');
  final widget = await child2widget(childBuilder());
  print('MyApp Returning Scope');
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
