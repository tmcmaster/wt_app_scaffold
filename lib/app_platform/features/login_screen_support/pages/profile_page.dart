import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_platform/features/login_screen_support/builders/action_builders.dart';
import 'package:wt_app_scaffold/app_platform/features/login_screen_support/config.dart';
import 'package:wt_firepod/wt_firepod.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(FirebaseProviders.auth);

    return ProfileScreen(
      auth: auth,
      actions: [
        SignedOutAction((context) {
          Navigator.pushReplacementNamed(context, '/');
        }),
        ActionBuilders.createAuthStateChangeAction(),
      ],
      actionCodeSettings: FirebaseAuthKeys.actionCodeSettings,
      showMFATile: true,
    );
  }
}
