import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_settings/wt_settings.dart';

class AppScaffoldPageControls extends StatelessWidget {
  final List<BaseSettingsProviders<StateNotifier, dynamic>> settingsProviders;

  const AppScaffoldPageControls({
    super.key,
    required this.settingsProviders,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: settingsProviders
          .map(
            (provider) => provider.component,
          )
          .toList(),
    );
  }
}
