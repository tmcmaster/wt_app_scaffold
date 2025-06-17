import 'package:flutter/material.dart';
import 'package:wt_action_button/action_button.dart';
import 'package:wt_app_definition/app_definition.dart';
import 'package:wt_app_scaffold/app_platform/auth/app_scaffold_authentication_store.dart';

class AppScaffoldLogoutAction extends ActionButtonDefinition {
  AppScaffoldLogoutAction(super.ref)
      : super(
            actionInfo: ActionInfo(
              icon: Icons.logout,
              label: 'Logout',
              tooltip: 'Logout',
            ),
            execute: (ref, notifier, _) {
              return notifier.run(() => ref.read(AppScaffoldAuthenticationStore.user.notifier).signOut());
            });
}
