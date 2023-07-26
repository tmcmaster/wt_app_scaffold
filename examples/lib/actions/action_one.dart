import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/wt_action_button.dart';
import 'package:wt_logging/wt_logging.dart';

class ActionOne extends ActionButtonDefinition {
  static final log = logger(ActionOne);

  static final provider = Provider(
    name: 'Action One',
    (ref) => ActionOne(ref),
  );

  ActionOne(super.ref)
      : super(
          label: 'Action One',
          icon: Icons.menu,
        );

  @override
  Future<void> execute() async {
    final notifier = ref.read(progress.notifier);
    notifier.start(total: 1);
    log.d('Doing Action......');
    await Future.delayed(const Duration(seconds: 5));
    log.d('Action Completed.');
    notifier.finished();
  }
}
