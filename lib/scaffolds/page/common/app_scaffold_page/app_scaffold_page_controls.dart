import 'package:flutter/material.dart';
import 'package:wt_app_definition/app_definition.dart';
import 'package:wt_app_scaffold/scaffolds/page/common/app_scaffold_page/app_scaffold_page_controls_card.dart';

class AppScaffoldPageControls extends StatelessWidget {
  final SettingsProvidersMap settingsProviders;

  const AppScaffoldPageControls({
    super.key,
    required this.settingsProviders,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Wrap(
          runSpacing: 16,
          spacing: 16,
          children: settingsProviders.entries
              .map(
                (entry) => AppScaffoldPageControlsCard(
                  title: entry.key,
                  settingsProviders: entry.value,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
