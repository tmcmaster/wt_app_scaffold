import 'package:firebase_auth/firebase_auth.dart';

// TODO: this needs to be turned into a class and supplied with a provider
mixin FirebaseAuthKeys {
  static const googleClientId =
      '626479055094-bq84775vo74g39v2170o2b4ciim1rdqe.apps.googleusercontent.com';
  static const googleRedirectURI =
      'https://wt-app-scaffold.web.app/__/auth/handler';
  static final actionCodeSettings = ActionCodeSettings(
    url: 'https://wt-app-scaffold.web.app',
    handleCodeInApp: true,
    androidMinimumVersion: '1',
    androidPackageName: 'net.wonkytech.sample_app',
    iOSBundleId: 'net.wonkytech.sampleApp',
  );
}
