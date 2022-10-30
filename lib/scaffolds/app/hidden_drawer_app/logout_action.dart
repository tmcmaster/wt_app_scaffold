import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/action_button_definition.dart';
import 'package:wt_action_button/utils/logging.dart';

export 'package:wt_action_button/wt_action_button.dart';

class LogoutAction extends ActionButtonDefinition {
  static final log = logger(LogoutAction, level: Level.debug);

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
    await Future.delayed(const Duration(seconds: 5));
    log.d('Logged Out.');
    notifier.finished();
  }
}
