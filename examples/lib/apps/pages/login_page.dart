import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_logging/wt_logging.dart';

class LoginPage extends ConsumerWidget {
  static final log = logger(LoginPage, level: Level.debug);

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final auth = ref.read(FirebaseProviders.auth);
                final user = auth.currentUser;

                if (user != null) {
                  log.d('User is already logged in: $user');
                } else {
                  final credentials = await auth.signInAnonymously();
                  log.d('User logged in anonymously: $credentials');
                }
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final auth = ref.read(FirebaseProviders.auth);
                final user = auth.currentUser;
                if (user == null) {
                  log.d('User is not currently logged in.');
                } else {
                  await ref.read(FirebaseProviders.auth).signOut();
                  log.d('User has been logged out.');
                }
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
