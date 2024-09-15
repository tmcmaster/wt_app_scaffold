import 'package:flutter/material.dart';
import 'package:wt_app_scaffold/app_platform/scaffold_app_dsl.dart';
import 'package:wt_app_scaffold_examples/secrets/firebase_options.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_logging/wt_logging.dart';

void main() {
  final log = logger('Login Test', level: Level.debug);

  runMyApp(
    andFirebase(
      andFirebaseLogin(
        asPlainApp(const Scaffold(
          body: Center(
            child: Text('Hello World'),
          ),
        )),
        emailEnabled: true,
        googleEnabled: true,
      ),
      appName: 'wt-app-scaffold',
      firebaseOptions: DefaultFirebaseOptions.currentPlatform,
      database: false,
      onReady: () {
        log.d('Application has loaded.');
      },
    ),
  );
}
