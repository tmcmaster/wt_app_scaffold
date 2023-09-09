import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
    bool auth = true,
    bool database = true,
    bool firestore = false,
    bool storage = false,
    bool functions = false,
    bool crashlytics = false,
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
    if (crashlytics) {
      log.i('Setting up Crashlytics');

      FlutterError.onError = (errorDetails) {
        FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      };
      // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };
    }

    final newContextMap = {
      ...contextMap,
      FirebaseProviders.appName: ProviderOverrideDefinition(
        value: appName,
        override: FirebaseProviders.appName.overrideWithValue(appName),
      ),
      FirebaseProviders.firebaseOptions: ProviderOverrideDefinition(
        value: firebaseOptions,
        override: FirebaseProviders.firebaseOptions
            .overrideWithValue(firebaseOptions),
      ),
      FirebaseProviders.app: ProviderOverrideDefinition(
        value: app,
        override: FirebaseProviders.app.overrideWithValue(app),
      ),
      if (auth) FirebaseProviders.auth: _initialiseAuth(app),
      if (database) FirebaseProviders.database: _initialiseDatabase(app),
      if (firestore) FirebaseProviders.firestore: _initialiseFirestore(app),
      if (storage) FirebaseProviders.storage: _initialiseStorage(app),
      if (functions) FirebaseProviders.functions: _initialiseFunctions(app),
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

  static ProviderOverrideDefinition _initialiseFunctions(
    FirebaseApp app,
  ) {
    final functionsInstance = FirebaseFunctions.instanceFor(app: app);
    return ProviderOverrideDefinition(
      value: functionsInstance,
      override:
          FirebaseProviders.functions.overrideWithValue(functionsInstance),
    );
  }

  static ProviderOverrideDefinition _initialiseStorage(
    FirebaseApp app,
  ) {
    final storageInstance = FirebaseStorage.instanceFor(app: app);
    return ProviderOverrideDefinition(
      value: storageInstance,
      override: FirebaseProviders.storage.overrideWithValue(storageInstance),
    );
  }

  static ProviderOverrideDefinition _initialiseAuth(
    FirebaseApp app,
  ) {
    final authInstance = FirebaseAuth.instanceFor(app: app);
    return ProviderOverrideDefinition(
      value: authInstance,
      override: FirebaseProviders.auth.overrideWithValue(authInstance),
    );
  }

  static ProviderOverrideDefinition _initialiseDatabase(
    FirebaseApp app,
  ) {
    final databaseInstance = FirebaseDatabase.instanceFor(app: app);
    return ProviderOverrideDefinition(
      value: databaseInstance,
      override: FirebaseProviders.database.overrideWithValue(databaseInstance),
    );
  }

  static ProviderOverrideDefinition _initialiseFirestore(
    FirebaseApp app,
  ) {
    final firestoreInstance = FirebaseFirestore.instanceFor(app: app);
    return ProviderOverrideDefinition(
      value: firestoreInstance,
      override:
          FirebaseProviders.firestore.overrideWithValue(firestoreInstance),
    );
  }
}
