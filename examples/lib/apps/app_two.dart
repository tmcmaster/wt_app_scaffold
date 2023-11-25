import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wt_app_scaffold/app_platform/features/login_screen_support/config.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/models/app_styles.dart';
import 'package:wt_app_scaffold_examples/apps/pages/firebase_page.dart';
import 'package:wt_app_scaffold_examples/apps/pages/login_page.dart';
import 'package:wt_app_scaffold_examples/apps/pages/navigation_page.dart';
import 'package:wt_app_scaffold_examples/apps/pages/plain_page.dart';
import 'package:wt_app_scaffold_examples/apps/pages/snack_bar_page.dart';
import 'package:wt_firepod/wt_firepod.dart';

mixin AppTwo {
  static final details = Provider<AppDetails>(
    name: 'AppTwo Details',
    (ref) => AppDetails(
      title: 'Application Two',
      subTitle: 'Second application',
      iconPath: 'assets/avocado.png',
    ),
  );

  static final definition = Provider<AppDefinition>(
    name: 'AppTwo Definition',
    (ref) => AppDefinition.from(
      appTitle: 'Application Two',
      appName: 'appTwp',
      swipeEnabled: true,
      includeAppBar: true,
      appDetailsProvider: details,
      applicationType: ApplicationType.hiddenDrawer,
      profilePage: PageDefinition(
        icon: Icons.person,
        title: 'Profile',
        builder: (_, __, ___) => ProfileScreen(
          auth: ref.read(FirebaseProviders.auth),
          actions: [
            SignedOutAction((context) {
              Navigator.pushReplacementNamed(context, '/');
            }),
          ],
          actionCodeSettings: FirebaseAuthKeys.actionCodeSettings,
          showMFATile: false,
        ),
      ),
      pages: [
        PageDefinition(
          title: 'Plain Page',
          icon: FontAwesomeIcons.clipboard,
          debug: false,
          builder: (_, __, ___) => const PlainPage(),
        ),
        PageDefinition(
          title: 'Firebase Page',
          icon: FontAwesomeIcons.clipboard,
          debug: false,
          builder: (_, __, ___) => const FirebasePage(),
        ),
        PageDefinition(
          title: 'SnackBar Page',
          icon: FontAwesomeIcons.clipboard,
          debug: false,
          builder: (_, __, ___) => const SnackBarPage(),
        ),
        PageDefinition(
          title: 'Navigation Page',
          icon: FontAwesomeIcons.bars,
          debug: false,
          builder: (_, __, ___) => const NavigationPage(
            routeTo: '/sign-in',
          ),
        ),
        PageDefinition(
          title: 'Login Page',
          icon: FontAwesomeIcons.clipboard,
          debug: false,
          builder: (_, __, ___) => const LoginPage(),
        ),
        PageDefinition(
          title: 'Settings',
          icon: Icons.settings,
          primary: true,
          builder: (context, __, ___) => VirtualSizeFittedBox(
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
    ),
  );

  static final styles = Provider<AppStyles>(
    name: 'AppTwo Styles',
    (ref) => GoRouterMenuApp.styles,
  );
}
