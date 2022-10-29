import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:utils/logging.dart';

import 'flutterfire_auth.dart';
import 'user_auth.dart';
import 'user_auth_result.dart';

class LinkEmailSignInForm extends HookConsumerWidget {
  static final log = logger(LinkEmailSignInForm);

  final FlutterfireAuthNotifier firebaseLogin;
  final String landingRoute;

  const LinkEmailSignInForm({
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
            child: Text('Link Email Sign In'),
            onPressed: () {
              print('Linking email sign in with logged in account: ${emailController.text}');
              firebaseLogin.linkEmailSignIn(emailController.text, passwordController.text).then((UserAuthResult auth) {
                log.d('Login completed : ${auth.success} : ${auth.user.name}');
                if (auth.user != UserAuth.none) {
                  log.d('Linking email sign in was successful. Routing to the default page.');
                  Navigator.of(context).pushReplacementNamed(landingRoute);
                } else {
                  log.d('Linking email sign in was not successful.');
                }
              });
            },
          ),
          ElevatedButton(
            child: Text('Unlink Email Sign In'),
            onPressed: () {
              print('Unlinking email sign in with logged in account: ${emailController.text}');
              firebaseLogin
                  .unlinkEmailSignIn(emailController.text, passwordController.text)
                  .then((UserAuthResult auth) {
                log.d('Login completed : ${auth.success} : ${auth.user.name}');
                if (auth.user != UserAuth.none) {
                  log.d('Unlinking email sign in was successful. Routing to the default page.');
                  Navigator.of(context).pushReplacementNamed(landingRoute);
                } else {
                  log.d('Unlinking email sign in was not successful.');
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
