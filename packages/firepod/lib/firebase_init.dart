import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firepod/auth/auth.dart';
import 'package:firepod/firebase_providers.dart';
import 'package:firepod/firepod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<ProviderScope> Function() Function(
  Future<dynamic> Function(
    FirebaseApp app,
    FirebaseOptions firebaseOptions,
  )
      childBuilder, {
  required String appName,
  required FirebaseOptions firebaseOptions,
}) withFirebase = andFirebase;

Future<ProviderScope> Function() andFirebase(
  Future<dynamic> Function(
    FirebaseApp app,
    FirebaseOptions firebaseOptions,
  )
      childBuilder, {
  required String appName,
  required FirebaseOptions firebaseOptions,
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

    print('Firebase Building Child');
    final widget = await child2widget(childBuilder(app, firebaseOptions));
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
