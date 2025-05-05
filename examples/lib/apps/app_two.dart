import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/models/app_styles.dart';
import 'package:wt_app_scaffold/models/page_info.dart';
import 'package:wt_app_scaffold/models/scaffold_page_type.dart';
import 'package:wt_app_scaffold/widgets/placeholder_page.dart';
import 'package:wt_app_scaffold_examples/apps/pages/firebase_page.dart';
import 'package:wt_app_scaffold_examples/apps/pages/login_page.dart';
import 'package:wt_app_scaffold_examples/apps/pages/navigation_page.dart';
import 'package:wt_app_scaffold_examples/apps/pages/plain_page.dart';
import 'package:wt_app_scaffold_examples/apps/pages/user_log_page.dart';

mixin AppTwo {
  static final details = AppDetails(
    title: 'Application Two',
    subTitle: 'Second application',
    iconPath: 'assets/avocado.png',
  );

  static final definition = AppDefinition.from(
    appTitle: 'Application Two',
    appName: 'appTwp',
    swipeEnabled: true,
    includeAppBar: true,
    applicationType: ApplicationType.goRouterMenu,
    scaffoldPageType: ScaffoldPageType.transparentCard,
    profilePage: PageDefinition(
      pageInfo: const PageInfo(
        name: 'profile',
        title: 'Profile',
        icon: Icons.person,
      ),
      primary: true,
      pageBuilder: (_) => const PlaceholderPage(
        title: 'Profile Page',
      ),
    ),
    pages: [
      PageDefinition(
        pageInfo: const PageInfo(
          name: 'plainPage',
          title: 'Plain Page',
          icon: FontAwesomeIcons.anchor,
        ),
        primary: true,
        debug: false,
        pageBuilder: (_) => const PlainPage(),
      ),
      PageDefinition(
        pageInfo: const PageInfo(
          name: 'firebasePage',
          title: 'Firebase Page',
          icon: FontAwesomeIcons.fire,
        ),
        primary: true,
        debug: false,
        pageBuilder: (_) => const FirebasePage(),
      ),
      PageDefinition(
        pageInfo: const PageInfo(
          name: 'snackBarPage',
          title: 'SnackBar Page',
          icon: FontAwesomeIcons.noteSticky,
        ),
        primary: true,
        debug: false,
        pageBuilder: (_) => const UserLogPage(),
      ),
      PageDefinition(
        pageInfo: const PageInfo(
          name: 'navigationPage',
          title: 'Navigation Page',
          icon: Icons.navigation,
        ),
        primary: true,
        debug: false,
        pageBuilder: (_) => const NavigationPage(
          routeTo: '/sign-in',
        ),
      ),
      PageDefinition(
        pageInfo: const PageInfo(
          name: 'loginPage',
          title: 'Login Page',
          icon: Icons.login,
        ),
        primary: true,
        debug: false,
        pageBuilder: (_) => const LoginPage(),
      ),
      PageDefinition(
        pageInfo: const PageInfo(
          name: 'settings',
          title: 'Settings',
          icon: Icons.settings,
        ),
        primary: true,
        pageBuilder: (pageContext) => VirtualSizeFittedBox(
          virtualSize: 1000,
          child: SettingsPage(
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
