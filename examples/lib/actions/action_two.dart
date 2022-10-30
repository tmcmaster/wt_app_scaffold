import 'package:wt_app_scaffold/app_scaffolds.dart';

export 'package:wt_action_button/wt_action_button.dart';

class ActionTwo extends ActionButtonDefinition {
  static final log = logger(ActionTwo, level: Level.debug);

  static final provider = Provider(
    name: 'Action Two',
    (ref) => ActionTwo(ref),
  );

  ActionTwo(super.ref)
      : super(
          label: 'Action Two',
          icon: Icons.menu,
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
