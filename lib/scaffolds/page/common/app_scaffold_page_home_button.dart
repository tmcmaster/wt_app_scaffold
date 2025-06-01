import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_platform/util/app_scaffold_router.dart';
import 'package:wt_app_scaffold/models/page_info.dart';
import 'package:wt_logging/wt_logging.dart';

class AppScaffoldPageHomeButton extends ConsumerWidget {
  static final log = logger(AppScaffoldPageHomeButton, level: Level.debug);

  final PageInfo homeRoute;
  final IconData icon;

  const AppScaffoldPageHomeButton({
    super.key,
    required this.homeRoute,
    required this.icon,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () {
        final routeString = homeRoute.route;
        log.d('ET phoning home: $routeString');
        ref.read(AppScaffoldRouter.provider).go(routeString);
      },
      icon: Icon(icon),
    );
  }
}
