import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_platform/app_scaffold_features.dart';
import 'package:wt_logging/wt_logging.dart';

class PlainPage extends ConsumerWidget {
  static final log = logger(PlainPage);

  const PlainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final backgroundColor = AppScaffoldFeatures.isGoRouterMenuApp(context)
        ? Colors.transparent
        : null;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              ':-)',
              style: textTheme.displayLarge,
            ),
          ],
        ),
      ),
    );
  }
}
