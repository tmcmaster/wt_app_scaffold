import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
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
    applicationType: ApplicationType.curvedNavBar,
    profilePage: PageDefinition(
      icon: Icons.person,
      title: 'Profile',
      builder: (_, __, ___, ____) => const PlaceholderPage(
        title: 'Profile Page',
      ),
    ),
    pages: [
      PageDefinition(
        title: 'Plain Page',
        icon: FontAwesomeIcons.clipboard,
        primary: true,
        debug: false,
        builder: (_, __, ___, ____) => const PlainPage(),
      ),
      PageDefinition(
        title: 'Firebase Page',
        icon: FontAwesomeIcons.clipboard,
        primary: true,
        debug: false,
        builder: (_, __, ___, ____) => const FirebasePage(),
      ),
      PageDefinition(
        title: 'SnackBar Page',
        icon: FontAwesomeIcons.clipboard,
        primary: true,
        landing: true,
        debug: false,
        builder: (_, __, ___, ____) => const UserLogPage(),
      ),
      PageDefinition(
        title: 'Navigation Page',
        icon: FontAwesomeIcons.bars,
        primary: true,
        debug: false,
        builder: (_, __, ___, ____) => const NavigationPage(
          routeTo: '/sign-in',
        ),
      ),
      PageDefinition(
        title: 'Login Page',
        icon: FontAwesomeIcons.clipboard,
        primary: true,
        debug: false,
        builder: (_, __, ___, ____) => const LoginPage(),
      ),
      PageDefinition(
        title: 'Settings',
        icon: Icons.settings,
        primary: true,
        builder: (context, __, ___, ____) => VirtualSizeFittedBox(
          virtualSize: 1000,
          child: SettingsPage(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/');
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    ],
  );

  static final styles = GoRouterMenuApp.styles;
}
