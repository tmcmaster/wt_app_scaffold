import 'package:flutter/material.dart';
import 'package:wt_action_button/action_button_definition.dart';
import 'package:wt_action_button/model/action_info.dart';
import 'package:wt_app_scaffold/app_platform/auth/app_scaffold_authentication_store.dart';

class AppScaffoldLogoutAction extends ActionButtonDefinition {
  AppScaffoldLogoutAction(super.ref)
      : super(
          actionInfo: ActionInfo(
            icon: Icons.logout,
            label: 'Logout',
            tooltip: 'Logout',
          ),
        );

  @override
  Future<void> execute() {
    return ref.read(AppScaffoldAuthenticationStore.user.notifier).signOut();
  }
}
