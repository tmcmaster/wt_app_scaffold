import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/app_details.dart';
import '../providers/app_scaffolds_providers.dart';
import 'provider_monitor.dart';

Future<ProviderScope> Function() Function(
  Future<dynamic> Function() childBuilder, {
  required Provider<AppDetails> appDetailsProvider,
}) withAppScaffold = andAppScaffold;

Future<ProviderScope> Function() andAppScaffold(
  Future<dynamic> Function() childBuilder, {
  required Provider<AppDetails> appDetailsProvider,
}) {
  return () async {
    print('AppScaffold Initialising');
    WidgetsFlutterBinding.ensureInitialized();
    print('AppScaffold Building Child');
    final widget = await child2widget(childBuilder());
    print('AppScaffold Returning Scope');
    return ProviderScope(
      overrides: [
        AppScaffoldProviders.appDetails.overrideWithProvider(appDetailsProvider),
        if (widget is ProviderScope) ...widget.overrides,
      ],
      observers: [
        ProviderMonitor.instance,
        if (widget is ProviderScope) ...widget.observers ?? [],
      ],
      child: widget is ProviderScope ? widget.child : widget,
    );
  };
}

void runMyApp(
  Future<dynamic> Function() childBuilder,
) async {
  print('MyApp Initialising');
  WidgetsFlutterBinding.ensureInitialized();
  print('MyApp Building Child');
  final widget = await child2widget(childBuilder());
  print('MyApp Returning Scope');
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
