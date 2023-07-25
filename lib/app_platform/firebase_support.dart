import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_platform/future_provider_scope.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_logging/wt_logging.dart';

class FirebaseSupport extends ConsumerWidget {
  static final log = logger(FirebaseSupport);

  final String appName;
  final FirebaseOptions firebaseOptions;
  final Widget child;
  const FirebaseSupport({
    super.key,
    required this.appName,
    required this.firebaseOptions,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureProviderScope(
      init: (ref) async {
        log.d('Firebase Initialising');
        WidgetsFlutterBinding.ensureInitialized();

        log.d('Firebase.initializeApp: name($appName)');
        final app = await Firebase.initializeApp(
          name: appName,
          options: firebaseOptions,
        );

        log.d('FirebaseAuth.instanceFor: name($appName)');
        final auth = FirebaseAuth.instanceFor(app: app);
        log.d('FirebaseDatabase.instanceFor: name($appName)');
        final database = FirebaseDatabase.instanceFor(app: app);

        return [
          FirebaseProviders.appName.overrideWithValue(appName),
          FirebaseProviders.firebaseOptions.overrideWithValue(firebaseOptions),
          FirebaseProviders.auth.overrideWithValue(auth),
          FirebaseProviders.app.overrideWithValue(app),
          FirebaseProviders.database.overrideWithValue(database),
        ];
      },
      child: child,
    );
  }
}
