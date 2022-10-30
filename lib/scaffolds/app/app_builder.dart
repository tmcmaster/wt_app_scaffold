import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';

class AppBuilder extends ConsumerWidget {
  static const routeName = '/';

  final AppDefinition appDefinition;

  const AppBuilder({
    super.key,
    required this.appDefinition,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final debugMode = ref.watch(ApplicationSettings.debugMode.value);
    final applicationType = ref.watch(ApplicationSettings.applicationType.value);

    final appBuilder = appBuilders[applicationType] ?? HiddenDrawerApp.build;
    return SafeArea(
      child: appBuilder(appDefinition, debugMode),
    );
  }
}
