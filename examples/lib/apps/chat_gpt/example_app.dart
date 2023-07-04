import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:riverpod/riverpod.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/scaffolds/login/config.dart';
import 'package:wt_firepod/wt_firepod.dart';

import 'example_pages.dart';

abstract class ExampleApp {
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
      debugMode: true,
      includeAppBar: true,
      appDetailsProvider: details,
      profilePage: PageDefinition(
        icon: Icons.person,
        title: 'Profile',
        builder: (context) => ProfileScreen(
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
          builder: (_) => const HomePage(),
        ),
        PageDefinition(
          title: 'Orders',
          icon: FontAwesomeIcons.bagShopping,
          primary: false,
          debug: true,
          builder: (_) => const OrdersPage(),
        ),
        PageDefinition(
          title: 'Products',
          icon: FontAwesomeIcons.cube,
          primary: false,
          debug: true,
          builder: (_) => const ProductsPage(),
        ),
        PageDefinition(
          title: 'Notifications',
          icon: FontAwesomeIcons.bell,
          primary: false,
          debug: true,
          builder: (_) => const NotificationsPage(),
        ),
        PageDefinition(
          title: 'Settings',
          icon: FontAwesomeIcons.gear,
          primary: false,
          debug: false,
          builder: (_) => const SettingsPage(),
        ),
      ],
    ),
  );
}