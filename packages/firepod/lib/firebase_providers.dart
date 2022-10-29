import "package:firebase_core/firebase_core.dart";
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

  @deprecated
  static List<Override> overrides({required String appName, required FirebaseOptions firebaseOptions}) {
    return [
      FirebaseProviders.appName.overrideWithValue(appName),
      FirebaseProviders.firebaseOptions.overrideWithValue(firebaseOptions),
    ];
  }
}
