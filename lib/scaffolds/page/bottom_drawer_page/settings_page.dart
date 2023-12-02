import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/providers/app_scaffolds_providers.dart';
import 'package:wt_logging/wt_logging.dart';

class SettingsPage extends ConsumerWidget {
  static final log = logger(SettingsPage);

  static const routeName = '/settings';

  final List<Widget> children;
  final bool childrenBefore;
  final bool hideAppBar;
  final Color backgroundColor;
  const SettingsPage({
    super.key,
    this.children = const [],
    this.childrenBefore = false,
    this.hideAppBar = true,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appDefinition = ref.read(AppScaffoldProviders.appDefinition);

    final isHiddenDraw = ref.read(ApplicationSettings.applicationType.value) ==
        ApplicationType.hiddenDrawer;

    final List<Widget> settingsComponents = [
      if (childrenBefore) ...children,
      const Text(
        'App Settings',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      ApplicationSettings.theme.component,
      ApplicationSettings.colorScheme.component,
      if (appDefinition.applicationType == null)
        ApplicationSettings.applicationType.component,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ApplicationSettings.debugMode.component,
          ApplicationSettings.verifyEmail.component,
        ],
      ),
      // ApplicationSettings.applicationType.component,
      if (!childrenBefore) ...children,
    ];

    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: hideAppBar
          ? null
          : AppBar(
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
