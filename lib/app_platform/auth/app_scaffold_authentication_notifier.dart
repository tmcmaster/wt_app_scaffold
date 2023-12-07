import 'package:wt_app_scaffold/app_platform/auth/app_scaffold_authentication_interface.dart';
import 'package:wt_app_scaffold/app_platform/auth/app_scaffold_user.dart';
import 'package:wt_logging/wt_logging.dart';

class AppScaffoldAuthenticationNotifier
    extends AppScaffoldAuthenticationInterface {
  static final log =
      logger(AppScaffoldAuthenticationNotifier, level: Level.debug);

  AppScaffoldAuthenticationNotifier()
      : super(
          AppScaffoldUser.empty(),
        );

  @override
  Future<void> signInWithEmail(String email, String password) async {
    log.d('Signing in user');
    state = const AppScaffoldUser(
      id: '',
      firstName: 'Dev',
      lastName: 'Five',
      email: '',
      authenticated: true,
    );
  }

  @override
  Future<void> signOut() async {
    log.d('Signing out user');
    state = AppScaffoldUser.empty();
  }

  @override
  Future<void> passwordReset() {
    // TODO: implement passwordReset
    throw UnimplementedError();
  }

  @override
  Future<void> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }
}
