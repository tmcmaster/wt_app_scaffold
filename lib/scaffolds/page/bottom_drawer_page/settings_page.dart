import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:utils/logging.dart';
import 'package:wt_app_scaffold/scaffolds/app/application_settings.dart';

class SettingsPage extends HookConsumerWidget {
  static final log = logger(SettingsPage);

  static const routeName = '/settings';

  final List<Widget> children;
  final bool childrenBefore;
  const SettingsPage({
    Key? key,
    this.children = const [],
    this.childrenBefore = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Widget> settingsComponents = [
      if (childrenBefore) ...children,
      const Text(
        'App Settings',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      ApplicationSettings.theme.component,
      ApplicationSettings.colorScheme.component,
      ApplicationSettings.debugMode.component,
      ApplicationSettings.applicationType.component,
      if (!childrenBefore) ...children,
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
          itemCount: settingsComponents.length,
          itemBuilder: (context, index) => settingsComponents[index],
          separatorBuilder: (context, index) => const SizedBox(height: 10),
        ),
      ),
    );
  }
}
