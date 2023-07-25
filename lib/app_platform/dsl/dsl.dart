import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:wt_app_scaffold/app_platform.dart';

void runMyApp(
  Widget child, {
  List<ProviderObserver> includeObservers = const [],
  List<Override> includeOverrides = const [],
  bool enableProviderMonitoring = false,
  Level setApplicationLogLevel = Level.warning,
  double? virtualSize,
}) {
  runApp(
    AppPlatform(
      includeOverrides: includeOverrides,
      includeObservers: includeObservers,
      enableProviderMonitoring: enableProviderMonitoring,
      setApplicationLogLevel: setApplicationLogLevel,
      virtualSize: virtualSize,
      child: child,
    ),
  );
}

const andFirebase = withFirebase;

Widget withFirebase(
  Widget child, {
  required String appName,
  required FirebaseOptions firebaseOptions,
}) {
  return FirebaseSupport(
    appName: appName,
    firebaseOptions: firebaseOptions,
    child: child,
  );
}

const andLogin = withLogin;

Widget withLogin(Widget child, {LoginSupport loginSupport = LoginSupport.none}) {
  return LoginScreenSupport(
    loginSupport: loginSupport,
    child: child,
  );
}

const andAppScaffold = withAppScaffold;

Widget withAppScaffold({
  required AlwaysAliveProviderBase<AppDefinition> appDefinition,
  required AlwaysAliveProviderBase<AppDetails> appDetails,
  double? virtualSize,
}) {
  return AppScaffoldSupport(appDetails: appDetails, appDefinition: appDefinition);
}
