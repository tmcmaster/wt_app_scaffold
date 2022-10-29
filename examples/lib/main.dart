import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firepod/firebase_init.dart';
// import 'demo_app.dart';

import 'package:firepod/login/firebase_auth_ui_example.dart';
import 'package:flutter/material.dart';
import 'package:sample_app/demo_app.dart';
import 'package:wt_app_scaffold/init/app_scaffold_init.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final app = await Firebase.initializeApp(
    name: 'wt-app-scaffold',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final auth = FirebaseAuth.instanceFor(app: app);

  final credentials = await auth.signInWithEmailAndPassword(email: 'tim@wonkytech.net', password: 'LetMeInPlease');
  print('USER: ${credentials.user?.email}');

  FirebaseDatabase database = FirebaseDatabase.instanceFor(app: app);
  final snapshot = await database.ref('v1').child('hello').get();
  print('Hello: ${snapshot.value}');

  runMyApp(
    withFirebase(
        andAppScaffold(
          () async => MaterialApp(
            home: FirebaseAuthUIExample(),
          ),
          appDetailsProvider: DemoApp.appDetails,
        ),
        appName: 'wt-app-scaffold',
        firebaseOptions: DefaultFirebaseOptions.currentPlatform),
  );
}
