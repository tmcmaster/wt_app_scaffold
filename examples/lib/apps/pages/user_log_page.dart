import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_platform/util/app_scaffold_features.dart';
import 'package:wt_logging/wt_logging.dart';

class UserLogPage extends ConsumerWidget {
  static final log = logger(UserLogPage);

  const UserLogPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backgroundColor = AppScaffoldFeatures.isGoRouterMenuApp(context) ? Colors.transparent : null;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(':-)'),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(UserLog.provider).log(
                      'Testing SnackBar',
                      showSnackBar: true,
                      showDialog: false,
                    );
              },
              child: const Text('Test SnackBar'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(UserLog.provider).log(
                      'Building Dialog',
                      showSnackBar: false,
                      showDialog: true,
                    );
              },
              child: const Text('Test Dialog'),
            ),
          ],
        ),
      ),
    );
  }
}
