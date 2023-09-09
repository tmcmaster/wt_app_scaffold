import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_logging/wt_logging.dart';

class NavigationPage extends ConsumerWidget {
  static final log = logger(NavigationPage);

  const NavigationPage({super.key});

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
                Navigator.of(context).pushReplacementNamed('/sign-in');
              },
              child: const Text('Test Navigation'),
            ),
          ],
        ),
      ),
    );
  }
}
