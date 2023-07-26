import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_platform/features/login_screen_support/builders/component_builders.dart';
import 'package:wt_app_scaffold/app_platform/features/login_screen_support/config.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_logging/wt_logging.dart';

class EmailVerificationPage extends ConsumerWidget {
  static final log = logger(EmailVerificationPage);

  const EmailVerificationPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(FirebaseProviders.auth);

    return EmailVerificationScreen(
      auth: auth,
      headerBuilder: ComponentBuilders.headerIcon(Icons.verified),
      sideBuilder: ComponentBuilders.sideIcon(Icons.verified),
      actionCodeSettings: FirebaseAuthKeys.actionCodeSettings,
      actions: [
        EmailVerifiedAction(() {
          log.d('Sending verification email.');
          auth.currentUser!.sendEmailVerification();
          Navigator.pushReplacementNamed(context, '/profile');
        }),
        AuthCancelledAction((context) {
          FirebaseUIAuth.signOut(context: context);
          Navigator.pushReplacementNamed(context, '/');
        }),
      ],
    );
  }
}
