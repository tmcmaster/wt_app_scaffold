import 'package:flutter/material.dart';
import 'package:wt_app_scaffold/models/app_scaffold_typedefs.dart';
import 'package:wt_app_scaffold/scaffolds/page/common/app_scaffold_page_controls_card.dart';

class AppScaffoldPageControls extends StatelessWidget {
  final AppScaffoldSettingsMapProviders settingsProviders;

  const AppScaffoldPageControls({
    super.key,
    required this.settingsProviders,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: settingsProviders.entries
          .map(
            (entry) => Center(
              child: AppScaffoldPageControlsCard(
                title: entry.key,
                settingsProviders: entry.value,
              ),
            ),
          )
          .toList(),
    );
  }
}
