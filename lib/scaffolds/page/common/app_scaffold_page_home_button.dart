import 'package:flutter/material.dart';
import 'package:wt_logging/wt_logging.dart';

class AppScaffoldPageHomeButton extends StatelessWidget {
  static final log = logger(AppScaffoldPageHomeButton, level: Level.debug);

  final String? homeRoute;

  const AppScaffoldPageHomeButton({
    super.key,
    required this.homeRoute,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        log.d('ET phoning home: $homeRoute');
      },
      icon: const Icon(Icons.home),
    );
  }
}
