import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/action_button_definition.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/providers/app_scaffolds_providers.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_logging/wt_logging.dart';

export 'package:wt_action_button/wt_action_button.dart';

class LogoutAction extends ActionButtonDefinition {
  static final log = logger(LogoutAction);

  static final provider = Provider(
    name: 'Logout Action',
    (ref) => LogoutAction(ref),
  );

  LogoutAction(super.ref)
      : super(
          label: 'Logout',
          icon: Icons.menu,
        );

  @override
  Future<void> execute() async {
    final notifier = ref.read(progress.notifier);
    notifier.start(total: 1);
    log.d('Logging Out......');
    await ref.read(FirebaseProviders.auth).signOut();
    final navigator = ref.read(AppScaffoldProviders.navigatorKey).currentState;
    navigator?.popAndPushNamed(AppBuilder.routeName);
    log.d('Logged Out.');
    notifier.finished();
  }
}
