import "package:firebase_core/firebase_core.dart";
import 'package:firebase_database/firebase_database.dart';
import 'package:firepod/auth/auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FirebaseProviders {
  static final appName = Provider<String>(
    name: 'FirebaseSetup.appName',
    (ref) => defaultFirebaseAppName,
  );
  static final firebaseOptions = Provider<FirebaseOptions>(
    name: 'FirebaseSetup.firebaseOptions',
    (ref) => throw Exception('Need to override the FirebaseOptions provider.'),
  );

  static final auth = Provider<FirebaseAuth>(
    name: 'FirebaseAuth',
    (ref) => throw Exception('Need to override the FirebaseAuth provider.'),
  );

  static final database = Provider<FirebaseDatabase>(
    name: 'FirebaseDatabase',
    (ref) => throw Exception('Need to override the FirebaseDatabase provider.'),
  );

  @deprecated
  static List<Override> overrides({required String appName, required FirebaseOptions firebaseOptions}) {
    return [
      FirebaseProviders.appName.overrideWithValue(appName),
      FirebaseProviders.firebaseOptions.overrideWithValue(firebaseOptions),
    ];
  }
}
