import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthKeys {
  static const googleClientId = '626479055094-bq84775vo74g39v2170o2b4ciim1rdqe.apps.googleusercontent.com';
  static const googleRedirectURI = 'https://wt-app-scaffold.web.app/__/auth/handler';

  static const twitterApiKey = String.fromEnvironment('TWITTER_API_KEY');
  static const twitterApiSecretKey = String.fromEnvironment('TWITTER_API_SECRET_KEY');
  static const twitterRedirectURi = 'ffire://';

  static const facebookClientId = '128693022464535';

  static final actionCodeSettings = ActionCodeSettings(
    url: 'wt-app-scaffold.web.app',
    handleCodeInApp: true,
    androidMinimumVersion: '1',
    androidPackageName: 'net.wonkytech.sample_app',
    iOSBundleId: 'net.wonkytech.sampleApp',
  );
}
