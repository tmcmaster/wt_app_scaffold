import 'package:firebase_auth/firebase_auth.dart';

const GOOGLE_CLIENT_ID = '626479055094-bq84775vo74g39v2170o2b4ciim1rdqe.apps.googleusercontent.com';
const GOOGLE_REDIRECT_URI = 'https://wt-app-scaffold.web.app/__/auth/handler';

const TWITTER_API_KEY = String.fromEnvironment('TWITTER_API_KEY');
const TWITTER_API_SECRET_KEY = String.fromEnvironment('TWITTER_API_SECRET_KEY');
const TWITTER_REDIRECT_URI = 'ffire://';

const FACEBOOK_CLIENT_ID = '128693022464535';

final actionCodeSettings = ActionCodeSettings(
  url: 'wt-app-scaffold.web.app',
  handleCodeInApp: true,
  androidMinimumVersion: '1',
  androidPackageName: 'net.wonkytech.sample_app',
  iOSBundleId: 'net.wonkytech.sampleApp',
);
