import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/app_details.dart';
import '../providers/app_scaffolds_providers.dart';
import 'provider_monitor.dart';

Future<ProviderScope> Function(
  dynamic child, {
  required Provider<AppDetails> appDetailsProvider,
}) withAppScaffold = andAppScaffold;

Future<ProviderScope> andAppScaffold(
  dynamic child, {
  required Provider<AppDetails> appDetailsProvider,
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  final widget = await child2widget(child);

  return ProviderScope(
    overrides: [
      AppScaffoldProviders.appDetails.overrideWithProvider(appDetailsProvider),
      if (widget is ProviderScope) ...widget.overrides,
    ],
    observers: [
      ProviderMonitor.instance,
      if (widget is ProviderScope) ...widget.observers ?? [],
    ],
    child: widget is ProviderScope ? widget.child : child,
  );
}

void runMyApp(
  dynamic child,
) async {
  WidgetsFlutterBinding.ensureInitialized();

  final widget = await child2widget(child);
  runApp(
    ProviderScope(
      observers: widget is ProviderScope ? widget.observers : null,
      overrides: widget is ProviderScope ? widget.overrides : [],
      child: widget is ProviderScope ? widget.child : widget,
    ),
  );
}

Future<Widget> child2widget(dynamic child) async {
  return child is Future<Widget> ? await child : child;
}
