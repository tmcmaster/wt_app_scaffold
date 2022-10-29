import "package:firebase_core/firebase_core.dart";
import "package:firebase_database/firebase_database.dart";
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'auth/auth.dart';
import 'firebase_providers.dart';

class FirebaseSetup {
  static final instance = FirebaseSetup._();

  late AlwaysAliveProviderBase<FirebaseApp> app;
  late AlwaysAliveProviderBase<FirebaseDatabase> database;
  late AlwaysAliveProviderBase<FirebaseAuth> auth;
  late StateNotifierProvider<FlutterfireAuthNotifier, UserAuth> login;

  FirebaseSetup._() {
    app = Provider(
      name: 'FirebaseSetup : App',
      (ref) {
        final appName = ref.read(FirebaseProviders.appName);
        return Firebase.app(appName);
      },
    );
    auth = Provider(
      name: 'FirebaseSetup : Auth',
      (ref) {
        final firebaseApp = ref.read(app);
        return FirebaseAuth.instanceFor(app: firebaseApp);
      },
    );
    database = Provider(name: 'FirebaseSetup : Database', (ref) {
      final firebaseApp = ref.read(app);
      return FirebaseDatabase.instanceFor(app: firebaseApp);
    });
    login = StateNotifierProvider<FlutterfireAuthNotifier, UserAuth>(
      name: 'FirebaseSetup : Login',
      (ref) {
        final firebaseAuth = ref.read(auth);
        final firebaseOptions = ref.read(FirebaseProviders.firebaseOptions);
        return FlutterfireAuthNotifier(ref, firebaseAuth: firebaseAuth, firebaseOptions: firebaseOptions);
      },
    );
  }
}
