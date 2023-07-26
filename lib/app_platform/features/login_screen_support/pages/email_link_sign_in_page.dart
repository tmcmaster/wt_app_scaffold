import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_platform/features/login_screen_support/builders/component_builders.dart';
import 'package:wt_app_scaffold/app_platform/features/login_screen_support/config.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_logging/wt_logging.dart';

class EmailLinkSignInPage extends ConsumerWidget {
  static final log = logger(EmailLinkSignInPage);

  const EmailLinkSignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(FirebaseProviders.auth);
    return EmailLinkSignInScreen(
      auth: auth,
      actions: [
        AuthStateChangeAction<SignedIn>((context, state) {
          Navigator.pushReplacementNamed(context, '/');
        }),
      ],
      provider: EmailLinkAuthProvider(
        actionCodeSettings: FirebaseAuthKeys.actionCodeSettings,
      ),
      headerMaxExtent: 200,
      headerBuilder: ComponentBuilders.headerIcon(Icons.link),
      sideBuilder: ComponentBuilders.sideIcon(Icons.link),
    );
  }
}
