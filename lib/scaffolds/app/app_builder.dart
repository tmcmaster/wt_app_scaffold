import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/providers/app_scaffolds_providers.dart';

class AppBuilder extends ConsumerWidget {
  static const routeName = '/sign-in';

  const AppBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appDefinition = ref.read(AppScaffoldProviders.appDefinition);
    final debugMode = ref.watch(ApplicationSettings.debugMode.value);
    final applicationType = ref.watch(AppScaffoldProviders.applicationType);

    final appBuilder = appBuilders[applicationType] ?? HiddenDrawerApp.build;
    return SafeArea(
      child: appBuilder(appDefinition, debugMode),
    );
  }
}
