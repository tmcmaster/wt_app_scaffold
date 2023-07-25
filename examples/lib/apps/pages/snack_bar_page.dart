import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_logging/wt_logging.dart';

class SnackBarPage extends ConsumerWidget {
  static final log = logger(SnackBarPage);

  const SnackBarPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
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
                        'Building Test App',
                        snackBar: true,
                        log: log.w,
                      );
                },
                child: const Text('Test SnackBar'))
          ],
        ),
      ),
    );
  }
}
