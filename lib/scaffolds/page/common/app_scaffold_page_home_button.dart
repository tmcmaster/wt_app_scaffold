import 'package:flutter/material.dart';
import 'package:wt_logging/wt_logging.dart';

class AppScaffoldPageHomeButton extends StatelessWidget {
  static final log = logger(AppScaffoldPageHomeButton, level: Level.debug);

  const AppScaffoldPageHomeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        log.d('ET phoning home.');
      },
      icon: const Icon(Icons.home),
    );
  }
}
