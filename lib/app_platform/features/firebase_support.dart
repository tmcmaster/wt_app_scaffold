import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_platform/models/feature_definition.dart';
import 'package:wt_app_scaffold/app_platform/models/provider_override_definition.dart';
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

  static Future<Map<ProviderListenable, ProviderOverrideDefinition>> init({
    required String appName,
    required FirebaseOptions firebaseOptions,
    required Map<ProviderListenable, ProviderOverrideDefinition> contextMap,
    FeatureDefinition? child,
  }) async {
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

    final newContextMap = {
      ...contextMap,
      FirebaseProviders.appName: ProviderOverrideDefinition(
        value: appName,
        override: FirebaseProviders.appName.overrideWithValue(appName),
      ),
      FirebaseProviders.firebaseOptions: ProviderOverrideDefinition(
        value: firebaseOptions,
        override: FirebaseProviders.firebaseOptions.overrideWithValue(firebaseOptions),
      ),
      FirebaseProviders.auth: ProviderOverrideDefinition(
        value: auth,
        override: FirebaseProviders.auth.overrideWithValue(auth),
      ),
      FirebaseProviders.app: ProviderOverrideDefinition(
        value: app,
        override: FirebaseProviders.app.overrideWithValue(app),
      ),
      FirebaseProviders.database: ProviderOverrideDefinition(
        value: database,
        override: FirebaseProviders.database.overrideWithValue(database),
      ),
    };

    if (child == null) {
      return newContextMap;
    } else {
      return child.initialiser(newContextMap);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return child;
  }
}
