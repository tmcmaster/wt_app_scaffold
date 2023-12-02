import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_platform/auth/app_scaffold_authentication_store.dart';

class AuthenticationButtons extends ConsumerWidget {
  const AuthenticationButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Wrap(
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/');
          },
          child: const Text('Login'),
        ),
        ElevatedButton(
          onPressed: () {
            ref.read(AppScaffoldAuthenticationStore.user.notifier).signOut();
            // ref.read(FirebaseProviders.auth).signOut();
          },
          child: const Text('Logout'),
        ),
      ],
    );
  }
}
