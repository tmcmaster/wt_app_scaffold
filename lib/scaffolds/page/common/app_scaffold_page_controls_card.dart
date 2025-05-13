import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/models/app_scaffold_typedefs.dart';

class AppScaffoldPageControlsCard extends ConsumerWidget {
  final String title;
  final AppScaffoldSettingsProviders settingsProviders;
  const AppScaffoldPageControlsCard({
    super.key,
    required this.title,
    required this.settingsProviders,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          //width: 300,
          child: Column(
            children: [
              Text(
                title,
                style: textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              ...settingsProviders.map((setting) => setting.component),
            ],
          ),
        ),
      ),
    );
  }
}
