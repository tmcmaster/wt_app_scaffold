import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/model/action_info.dart';
import 'package:wt_action_button/wt_action_button.dart';
import 'package:wt_logging/wt_logging.dart';

class ActionTwo extends ActionButtonDefinition {
  static final log = logger(ActionTwo);

  static final provider = Provider(
    name: 'Action Two',
    (ref) => ActionTwo(ref),
  );

  ActionTwo(super.ref)
      : super(
          actionInfo: ActionInfo(
            label: 'Action Two',
            tooltip: 'Action Two',
            icon: Icons.menu,
          ),
        );

  @override
  Future<void> execute() async {
    final notifier = ref.read(progress.notifier);
    notifier.start(total: 1);
    log.d('Doing Action......');
    await Future.delayed(const Duration(seconds: 2));
    log.d('Action Completed.');
    notifier.finished();
  }
}
