import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_apple/firebase_ui_oauth_apple.dart';
import 'package:firebase_ui_oauth_facebook/firebase_ui_oauth_facebook.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:firebase_ui_oauth_twitter/firebase_ui_oauth_twitter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/providers/app_scaffolds_providers.dart';
import 'package:wt_app_scaffold/scaffolds/login/config.dart';
import 'package:wt_logging/wt_logging.dart';

Future<ProviderScope> Function(
  FirebaseApp app,
  FirebaseOptions firebaseOptions,
)
    Function({
  required AlwaysAliveProviderBase<AppDefinition> appDefinition,
  required AlwaysAliveProviderBase<AppDetails> appDetails,
  required LoginSupport loginSupport,
}) withAppScaffold = andAppScaffold;

Future<ProviderScope> Function(
  FirebaseApp app,
  FirebaseOptions firebaseOptions,
) andAppScaffold({
  required AlwaysAliveProviderBase<AppDefinition> appDefinition,
  required AlwaysAliveProviderBase<AppDetails> appDetails,
  required LoginSupport loginSupport,
}) {
  return (app, firebaseOptions) async {
    WidgetsFlutterBinding.ensureInitialized();
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
        if (loginSupport.twitterEnabled)
          FacebookProvider(clientId: FirebaseAuthKeys.facebookClientId),
        if (loginSupport.twitterEnabled)
          TwitterProvider(
            apiKey: FirebaseAuthKeys.twitterApiKey,
            apiSecretKey: FirebaseAuthKeys.twitterApiSecretKey,
            redirectUri: FirebaseAuthKeys.twitterRedirectURi,
          ),
      ],
      app: app,
    );

    return ProviderScope(
      overrides: [
        UserLog.snackBarKey.overrideWithValue(AppContainer.snackBarKey),
        AppScaffoldProviders.appDefinition.overrideWith((ref) => ref.read(appDefinition)),
        AppScaffoldProviders.appDetails.overrideWith((ref) => ref.read(appDetails)),
      ],
      observers: const [],
      child: const LoginAppContainer(),
    );
  };
}

Future<void> runMyApp(
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
  return child is Future<Widget> ? await child : child as Widget;
}
