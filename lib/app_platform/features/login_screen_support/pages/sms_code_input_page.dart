import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_platform/features/login_screen_support/builders/component_builders.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_logging/wt_logging.dart';

class SMSCodeInputPage extends ConsumerWidget {
  static final log = logger(SMSCodeInputPage);

  const SMSCodeInputPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(FirebaseProviders.auth);
    final arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return SMSCodeInputScreen(
      auth: auth,
      actions: [
        AuthStateChangeAction<SignedIn>((context, state) {
          Navigator.of(context).pushReplacementNamed('/profile');
        })
      ],
      flowKey: arguments?['flowKey'] as Object,
      action: arguments?['action'] as AuthAction?,
      headerBuilder: ComponentBuilders.headerIcon(Icons.sms_outlined),
      sideBuilder: ComponentBuilders.sideIcon(Icons.sms_outlined),
    );
  }
}
