import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wt_action_button/model/action_info.dart';
import 'package:wt_action_button/wt_action_button.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_logging/wt_logging.dart';

class DatabaseAction extends ActionButtonDefinition {
  static final log = logger(DatabaseAction);

  static final provider = Provider(
    name: 'Database Action',
    (ref) => DatabaseAction(ref),
  );

  DatabaseAction(super.ref)
      : super(
          actionInfo: ActionInfo(
            label: 'Database Action',
            tooltip: 'Database Action',
            icon: FontAwesomeIcons.database,
          ),
        );

  @override
  Future<void> execute() async {
    final notifier = ref.read(progress.notifier);
    notifier.run(() async {
      log.d('Doing Database Action......');
      final hello = await ref.read(FirebaseProviders.database).ref('v1').child('hello').get();
      log.d('Database Action Completed: ${hello.value}');
      final person = await ref.read(FirebaseProviders.database).ref('v1').child('product').get();
      log.d('Person(${person.value})');
    });
  }
}
