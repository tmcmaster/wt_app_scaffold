import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/providers/app_scaffolds_providers.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_logging/wt_logging.dart';

class FirebasePage extends ConsumerWidget {
  static final log = logger(FirebasePage);

  const FirebasePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(':-)'),
            Text('FirebaseAuth : ${ref.read(FirebaseProviders.auth)}'),
            Text('App Name : ${ref.read(FirebaseProviders.appName)}'),
            Text('Navigator Key : ${ref.read(AppScaffoldProviders.navigatorKey)}'),
            ElevatedButton(
                onPressed: () {
                  ref.read(FirebaseProviders.auth).signOut();
                  ref
                      .read(AppScaffoldProviders.navigatorKey)
                      .currentState
                      ?.pushReplacementNamed('/sign-in');
                },
                child: const Text('Logout')),
          ],
        ),
      ),
    );
  }
}
