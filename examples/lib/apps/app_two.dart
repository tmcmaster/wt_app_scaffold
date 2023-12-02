import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wt_app_scaffold/app_platform/config/shared_app_config.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/models/app_styles.dart';
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
      icon: Icons.person,
      title: 'Profile',
      primary: true,
      builder: (_) => const PlaceholderPage(
        title: 'Profile Page',
      ),
    ),
    pages: [
      PageDefinition(
        title: 'Plain Page',
        icon: FontAwesomeIcons.anchor,
        primary: true,
        debug: false,
        builder: (_) => const PlainPage(),
      ),
      PageDefinition(
        title: 'Firebase Page',
        icon: FontAwesomeIcons.fire,
        primary: true,
        debug: false,
        builder: (_) => const FirebasePage(),
      ),
      PageDefinition(
        title: 'SnackBar Page',
        icon: FontAwesomeIcons.noteSticky,
        primary: true,
        debug: false,
        builder: (_) => const UserLogPage(),
      ),
      PageDefinition(
        title: 'Navigation Page',
        icon: Icons.navigation,
        primary: true,
        debug: false,
        builder: (_) => const NavigationPage(
          routeTo: '/sign-in',
        ),
      ),
      PageDefinition(
        title: 'Login Page',
        icon: Icons.login,
        primary: true,
        debug: false,
        builder: (_) => const LoginPage(),
      ),
      PageDefinition(
        title: 'Settings',
        icon: Icons.settings,
        primary: true,
        builder: (pageContext) => VirtualSizeFittedBox(
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
