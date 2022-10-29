import 'package:firebase_core/firebase_core.dart';
import 'package:firepod/firebase_providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<ProviderScope> Function(
  dynamic child, {
  required String appName,
  required FirebaseOptions firebaseOptions,
}) withFirebase = andFirebase;

Future<ProviderScope> andFirebase(
  dynamic child, {
  required String appName,
  required FirebaseOptions firebaseOptions,
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: appName,
    options: firebaseOptions,
  );
  final widget = await child2widget(child);
  return ProviderScope(
    overrides: [
      FirebaseProviders.appName.overrideWithValue(appName),
      FirebaseProviders.firebaseOptions.overrideWithValue(firebaseOptions),
      if (widget is ProviderScope) ...widget.overrides,
    ],
    observers: [
      if (widget is ProviderScope) ...widget.observers ?? [],
    ],
    child: widget is ProviderScope ? widget.child : child,
  );
}

Future<Widget> child2widget(dynamic child) async {
  return child is Future<Widget> ? await child : child;
}
