import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_platform/auth/app_scaffold_user.dart';

abstract class AppScaffoldAuthenticationInterface
    extends StateNotifier<AppScaffoldUser> {
  AppScaffoldAuthenticationInterface(super.state);

  Future<void> signInWithEmail(String email, String password);
  Future<void> signInWithGoogle();
  Future<void> passwordReset();
  Future<void> signOut();
}
