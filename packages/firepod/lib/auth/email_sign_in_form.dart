import 'package:firepod/utils/logging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'flutterfire_auth.dart';
import 'user_auth.dart';
import 'user_auth_result.dart';

class EmailSignInForm extends HookConsumerWidget {
  static final log = logger(EmailSignInForm);

  final FlutterfireAuthNotifier firebaseLogin;
  final String landingRoute;

  const EmailSignInForm({
    super.key,
    required this.firebaseLogin,
    required this.landingRoute,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    return SizedBox(
      width: 300,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          TextField(
            controller: passwordController,
            obscureText: true,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            child: Text('Email Sign In'),
            onPressed: () {
              print('Logging in with email: ${emailController.text}');
              firebaseLogin.emailSignIn(emailController.text, passwordController.text).then((UserAuthResult auth) {
                log.d('Login completed : ${auth.success} : ${auth.user.name}');
                if (auth.user != UserAuth.none) {
                  log.d('Routing to the default page');
                  Navigator.of(context).pushReplacementNamed(landingRoute);
                } else {
                  log.d('Authentication was not successful.');
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
