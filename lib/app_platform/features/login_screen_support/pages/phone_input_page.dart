import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_platform/features/login_screen_support/builders/component_builders.dart';
import 'package:wt_firepod/wt_firepod.dart';

class PhoneInputPage extends ConsumerWidget {
  const PhoneInputPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(FirebaseProviders.auth);

    return PhoneInputScreen(
      auth: auth,
      actions: [
        SMSCodeRequestedAction((context, action, flowKey, phone) {
          Navigator.of(context).pushReplacementNamed(
            '/sms',
            arguments: {
              'action': action,
              'flowKey': flowKey,
              'phone': phone,
            },
          );
        }),
      ],
      headerBuilder: ComponentBuilders.headerIcon(Icons.phone),
      sideBuilder: ComponentBuilders.sideIcon(Icons.phone),
    );
  }
}
