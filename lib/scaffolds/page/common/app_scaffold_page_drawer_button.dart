import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wt_logging/wt_logging.dart';

class AppScaffoldPageDrawerButton extends StatelessWidget {
  static final log = logger(AppScaffoldPageDrawerButton, level: Level.debug);

  const AppScaffoldPageDrawerButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        log.d('===> Opening Drawer');
        Scaffold.of(context).openDrawer();
      },
      icon: const Icon(FontAwesomeIcons.gear),
    );
  }
}
