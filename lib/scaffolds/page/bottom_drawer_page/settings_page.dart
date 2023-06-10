import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_logging/wt_logging.dart';

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
    final isHiddenDraw =
        ref.read(ApplicationSettings.applicationType.value) == ApplicationType.hiddenDrawer;

    final List<Widget> settingsComponents = [
      if (childrenBefore) ...children,
      const Text(
        'App Settings',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      ApplicationSettings.theme.component,
      ApplicationSettings.colorScheme.component,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ApplicationSettings.debugMode.component,
          ApplicationSettings.verifyEmail.component,
        ],
      ),
      ApplicationSettings.applicationType.component,
      if (!childrenBefore) ...children,
    ];

    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: isHiddenDraw
            ? IconButton(
                onPressed: () {
                  HiddenDrawerOpener.of(context)?.open();
                },
                focusColor: Colors.transparent,
                icon: Icon(
                  Icons.menu,
                  color: colorScheme.onPrimary,
                ),
              )
            : null,
      ),
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
