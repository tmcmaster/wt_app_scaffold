import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wt_app_scaffold/app_platform/app_scaffold_features.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_logging/wt_logging.dart';

class NavigationPage extends ConsumerWidget {
  static final log = logger(NavigationPage);

  final String routeTo;
  const NavigationPage({
    super.key,
    required this.routeTo,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backgroundColor = AppScaffoldFeatures.isGoRouterMenuApp(context)
        ? Colors.transparent
        : null;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(':-)'),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                if (AppScaffoldFeatures.isGoRouterMenuApp(context)) {
                  context.go('/plain');
                } else if (AppScaffoldFeatures.isCurvedNavBarApp(context)) {
                  ref
                      .read(CurvedNavBarApp.controller.notifier)
                      .changePage('/plain');
                } else {
                  Navigator.of(context).pushReplacementNamed(routeTo);
                }
              },
              child: const Text('Test Navigation'),
            ),
          ],
        ),
      ),
    );
  }
}
