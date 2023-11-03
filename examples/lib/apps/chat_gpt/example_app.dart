import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wt_app_scaffold/app_platform/features/login_screen_support/config.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold_examples/apps/chat_gpt/example_pages.dart';
import 'package:wt_firepod/wt_firepod.dart';

mixin ExampleApp {
  static final details = Provider<AppDetails>(
    name: 'Example App Details',
    (ref) => AppDetails(
      title: 'Example App',
      subTitle: 'created by ChatGPT',
      iconPath: 'assets/avocado.png',
    ),
  );

  static final definition = Provider<AppDefinition>(
    name: 'Example App Definition',
    (ref) => AppDefinition.from(
      appTitle: 'Example App',
      appName: 'exampleApp',
      swipeEnabled: true,
      includeAppBar: true,
      appDetailsProvider: details,
      profilePage: PageDefinition(
        icon: Icons.person,
        title: 'Profile',
        builder: (context, _) => ProfileScreen(
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
          title: 'Home',
          icon: Icons.home,
          primary: true,
          debug: false,
          builder: (_, __) => const HomePage(),
        ),
        PageDefinition(
          title: 'Orders',
          icon: FontAwesomeIcons.bagShopping,
          primary: false,
          debug: true,
          builder: (_, __) => const OrdersPage(),
        ),
        PageDefinition(
          title: 'Products',
          icon: FontAwesomeIcons.cube,
          primary: false,
          debug: true,
          builder: (_, __) => const ProductsPage(),
        ),
        PageDefinition(
          title: 'Notifications',
          icon: FontAwesomeIcons.bell,
          primary: false,
          debug: true,
          builder: (_, __) => const NotificationsPage(),
        ),
        PageDefinition(
          title: 'Settings',
          icon: FontAwesomeIcons.gear,
          primary: false,
          debug: false,
          builder: (_, __) => const SettingsPage(),
        ),
      ],
    ),
  );
}
