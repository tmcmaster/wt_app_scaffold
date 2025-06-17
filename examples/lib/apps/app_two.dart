import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wt_app_definition/app_definition.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold_examples/apps/pages/firebase_page.dart';
import 'package:wt_app_scaffold_examples/apps/pages/login_page.dart';
import 'package:wt_app_scaffold_examples/apps/pages/navigation_page.dart';
import 'package:wt_app_scaffold_examples/apps/pages/plain_page.dart';
import 'package:wt_app_scaffold_examples/apps/pages/user_log_page.dart';
import 'package:wt_prototyping/prototyping.dart';

mixin AppTwo {
  static final definition = AppDefinition.from(
    appDetails: AppDetails(
      name: 'applicationTwo',
      title: 'Application Two',
      subTitle: 'Second application',
      iconPath: 'assets/avocado.png',
    ),
    swipeEnabled: true,
    includeAppBar: true,
    pageType: AppScaffoldPageType.transparentCard,
    profilePage: PageDefinition(
      info: PageInfo(
        name: 'profile',
        title: 'Profile',
        icon: Icons.person,
        itemType: ItemType.primary,
      ),
      pageBuilder: (_) => const PlaceholderPage(
        title: 'Profile Page',
      ),
    ),
    pages: [
      PageDefinition(
        info: PageInfo(
          name: 'plainPage',
          title: 'Plain Page',
          icon: FontAwesomeIcons.anchor,
          itemType: ItemType.primary,
        ),
        pageBuilder: (_) => const PlainPage(),
      ),
      PageDefinition(
        info: PageInfo(
          name: 'firebasePage',
          title: 'Firebase Page',
          icon: FontAwesomeIcons.fire,
          itemType: ItemType.primary,
        ),
        pageBuilder: (_) => const FirebasePage(),
      ),
      PageDefinition(
        info: PageInfo(
          name: 'snackBarPage',
          title: 'SnackBar Page',
          icon: FontAwesomeIcons.noteSticky,
          itemType: ItemType.primary,
        ),
        pageBuilder: (_) => const UserLogPage(),
      ),
      PageDefinition(
        info: PageInfo(
          name: 'navigationPage',
          title: 'Navigation Page',
          icon: Icons.navigation,
          itemType: ItemType.primary,
        ),
        pageBuilder: (_) => const NavigationPage(
          routeTo: '/sign-in',
        ),
      ),
      PageDefinition(
        info: PageInfo(
          name: 'loginPage',
          title: 'Login Page',
          icon: Icons.login,
          itemType: ItemType.primary,
        ),
        pageBuilder: (_) => const LoginPage(),
      ),
      PageDefinition(
        info: PageInfo(
          name: 'settings',
          title: 'Settings',
          icon: Icons.settings,
          itemType: ItemType.primary,
        ),
        pageBuilder: (pageContext) => VirtualSizeFittedBox(
          virtualSize: 1000,
          child: AppScaffoldSettingsPage(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(pageContext.context).pushNamed('/');
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    ],
  );

  static AppStyles styles(Ref ref) => SharedAppConfig.styles(ref);
}
