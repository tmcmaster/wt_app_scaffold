import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_platform/features/login_screen_support/builders/component_builders.dart';
import 'package:wt_firepod/wt_firepod.dart';

class ForgotPasswordPage extends ConsumerWidget {
  const ForgotPasswordPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(FirebaseProviders.auth);

    final arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    return ForgotPasswordScreen(
      auth: auth,
      email: arguments?['email'] as String?,
      headerMaxExtent: 200,
      headerBuilder: ComponentBuilders.headerIcon(Icons.lock),
      sideBuilder: ComponentBuilders.sideIcon(Icons.lock),
    );
  }
}
