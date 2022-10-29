import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

const GOOGLE_CLIENT_ID = '448618578101-sg12d2qin42cpr00f8b0gehs5s7inm0v.apps.googleusercontent.com';
const GOOGLE_REDIRECT_URI = 'https://react-native-firebase-testing.firebaseapp.com/__/auth/handler';

const TWITTER_API_KEY = String.fromEnvironment('TWITTER_API_KEY');
const TWITTER_API_SECRET_KEY = String.fromEnvironment('TWITTER_API_SECRET_KEY');
const TWITTER_REDIRECT_URI = 'ffire://';

const FACEBOOK_CLIENT_ID = '128693022464535';

final actionCodeSettings = ActionCodeSettings(
  url: 'https://flutterfire-e2e-tests.firebaseapp.com',
  handleCodeInApp: true,
  androidMinimumVersion: '1',
  androidPackageName: 'io.flutter.plugins.firebase_ui.firebase_ui_example',
  iOSBundleId: 'io.flutter.plugins.fireabaseUiExample',
);
final emailLinkProviderConfig = EmailLinkAuthProvider(
  actionCodeSettings: actionCodeSettings,
);
