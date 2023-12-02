import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/action_button_definition.dart';
import 'package:wt_app_scaffold/app_platform/auth/app_scaffold_authentication_store.dart';

mixin AuthProviders {
  static final loginEnabled = Provider<bool>(
    name: 'AuthProviders.loginEnabled',
    (ref) => false,
  );

  static final logoutAction = Provider<ActionButtonDefinition>(
    name: 'AuthProviders.logoutAction',
    (ref) => AppScaffoldLogoutAction(ref),
  );
}

class AppScaffoldLogoutAction extends ActionButtonDefinition {
  AppScaffoldLogoutAction(super.ref)
      : super(
          icon: Icons.logout,
          label: 'Logout',
        );

  @override
  Future<void> execute() {
    return ref.read(AppScaffoldAuthenticationStore.user.notifier).signOut();
  }
}
