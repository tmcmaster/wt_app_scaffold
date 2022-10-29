import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firepod/auth/auth.dart';
import 'package:firepod/firebase_providers.dart';
import 'package:firepod/firepod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../login/config.dart';

Future<ProviderScope> Function() Function(
  Future<dynamic> Function() childBuilder, {
  required String appName,
  required FirebaseOptions firebaseOptions,
}) withFirebase = andFirebase;

Future<ProviderScope> Function() andFirebase(
  Future<dynamic> Function() childBuilder, {
  required String appName,
  required FirebaseOptions firebaseOptions,
  googleEnabled = false,
  emailEnabled = true,
  twitterEnabled = false,
  facebookEnabled = false,
  appleEnabled = false,
  phoneEnabled = false,
  emailLinkEnabled = false,
}) {
  return () async {
    print('Firebase Initialising');
    WidgetsFlutterBinding.ensureInitialized();

    print('Firebase.initializeApp: name($appName)');
    final app = await Firebase.initializeApp(
      name: appName,
      options: firebaseOptions,
    );

    print('FirebaseAuth.instanceFor: name($appName)');
    final auth = FirebaseAuth.instanceFor(app: app);
    print('FirebaseDatabase.instanceFor: name($appName)');
    final database = FirebaseDatabase.instanceFor(app: app);

    print('FirebaseUIAuth.configureProviders: name($appName)');
    FirebaseUIAuth.configureProviders(
      [
        if (emailEnabled) EmailAuthProvider(),
        if (emailLinkEnabled) emailLinkProviderConfig,
        if (phoneEnabled) PhoneAuthProvider(),
        if (googleEnabled) GoogleProvider(clientId: GOOGLE_CLIENT_ID),
        if (appleEnabled) AppleProvider(),
        if (twitterEnabled) FacebookProvider(clientId: FACEBOOK_CLIENT_ID),
        if (twitterEnabled)
          TwitterProvider(
            apiKey: TWITTER_API_KEY,
            apiSecretKey: TWITTER_API_SECRET_KEY,
            redirectUri: TWITTER_REDIRECT_URI,
          ),
      ],
      app: app,
    );

    print('Firebase Building Child');
    final widget = await child2widget(childBuilder());
    print('Firebase Returning Scope');
    return ProviderScope(
      overrides: [
        FirebaseProviders.appName.overrideWithValue(appName),
        FirebaseProviders.firebaseOptions.overrideWithValue(firebaseOptions),
        FirebaseProviders.auth.overrideWithValue(auth),
        FirebaseProviders.database.overrideWithValue(database),
        if (widget is ProviderScope) ...widget.overrides,
      ],
      observers: [
        if (widget is ProviderScope) ...widget.observers ?? [],
      ],
      child: widget is ProviderScope ? widget.child : widget,
    );
  };
}

Future<Widget> child2widget(dynamic child) async {
  return child is Future<Widget> ? await child : child;
}
