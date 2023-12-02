import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_platform/util/app_scaffold_router.dart';
import 'package:wt_app_scaffold_examples/data/firebase_data.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_logging/wt_logging.dart';

class FirebasePage extends ConsumerWidget {
  static final log = logger(FirebasePage);

  const FirebasePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(':-)'),
              Text('FirebaseAuth : ${ref.read(FirebaseProviders.auth)}'),
              Text('App Name : ${ref.read(FirebaseProviders.appName)}'),
              Text('Navigator Key : ${ref.read(UserLogStore.navigatorKey)}'),
              Text(
                'Firebase Data : ${ref.read(FirebaseData.firebaseDatabase)}',
              ),
              ElevatedButton(
                onPressed: () {
                  ref.read(FirebaseProviders.auth).signOut();
                },
                child: const Text('Logout'),
              ),
              ElevatedButton(
                onPressed: () {
                  ref.read(AppScaffoldRouter.provider).go('/settings');
                },
                child: const Text('Settings'),
              ),
            ]
                .map(
                  (widget) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: widget,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
