import 'package:flutter/material.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold_examples/apps/app_one.dart';
import 'package:wt_app_scaffold_examples/firebase_options.dart';

void main() {
  runApp(
    AppPlatform(
      virtualSize: 1200,
      child: FirebaseSupport(
        appName: 'wt-app-scaffold',
        firebaseOptions: DefaultFirebaseOptions.currentPlatform,
        child: LoginScreenSupport(
          loginSupport: const LoginSupport(
            emailEnabled: true,
            googleEnabled: true,
          ),
          child: AppScaffoldSupport(
            appDetails: AppOne.details,
            appDefinition: AppOne.definition,
          ),
        ),
      ),
    ),
  );
}
