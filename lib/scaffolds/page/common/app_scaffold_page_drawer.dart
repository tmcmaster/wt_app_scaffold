import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/scaffolds/page/common/app_scaffold_page_controls.dart';
import 'package:wt_settings/wt_settings.dart';

class AppScaffoldPageDrawer extends StatelessWidget {
  final List<BaseSettingsProviders<StateNotifier, dynamic>> settingsProviders;

  const AppScaffoldPageDrawer({
    super.key,
    required this.settingsProviders,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        appBar: AppBar(
          title: const Row(
            children: [
              Text('Settings'),
            ],
          ),
        ),
        body: AppScaffoldPageControls(settingsProviders: settingsProviders),
      ),
    );
  }
}
