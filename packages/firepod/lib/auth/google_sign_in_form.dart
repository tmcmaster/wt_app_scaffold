import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:utils/logging.dart';

import 'flutterfire_auth.dart';
import 'user_auth.dart';
import 'user_auth_result.dart';

class GoogleSignInForm extends HookConsumerWidget {
  static final log = logger(GoogleSignInForm);

  final FlutterfireAuthNotifier firebaseLogin;
  final String landingRoute;

  const GoogleSignInForm({
    super.key,
    required this.firebaseLogin,
    required this.landingRoute,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      child: Text('Google Sign In'),
      onPressed: () {
        print('Logging in with google');
        firebaseLogin.googleSignIn().then((UserAuthResult auth) {
          log.d('Login completed : ${auth.success} : ${auth.user.name}');
          if (auth.user != UserAuth.none) {
            log.d('Routing to the default page');
            Navigator.of(context).pushReplacementNamed(landingRoute);
          } else {
            log.d('Authentication was not successful.');
          }
        });
      },
    );
  }
}
