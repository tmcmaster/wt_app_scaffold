import 'package:firebase_auth/firebase_auth.dart';

import 'user_auth.dart';

class UserAuthResult {
  final ConfirmationResult? confirmationResult;
  final UserAuth user;
  final String? error;

  UserAuthResult({this.user = UserAuth.none, this.error, this.confirmationResult});

  factory UserAuthResult.error(String error) {
    return UserAuthResult(user: UserAuth.none, error: error);
  }

  factory UserAuthResult.success(UserAuth user) {
    return UserAuthResult(user: user);
  }

  factory UserAuthResult.confirmation(ConfirmationResult confirmationResult) {
    return UserAuthResult(confirmationResult: confirmationResult);
  }

  bool get success => error != null;
}
