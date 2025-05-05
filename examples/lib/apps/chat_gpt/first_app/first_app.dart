import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/models/page_info.dart';
import 'package:wt_app_scaffold/widgets/placeholder_page.dart';
import 'package:wt_app_scaffold_examples/apps/chat_gpt/first_app/first_app_pages.dart';

mixin FirstApp {
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
        pageInfo: const PageInfo(
          name: 'profile',
          title: 'Profile',
          icon: Icons.person,
        ),
        pageBuilder: (_) => const PlaceholderPage(
          title: 'Profile Screen',
        ),
      ),
      pages: [
        PageDefinition(
          pageInfo: const PageInfo(
            name: 'home',
            title: 'Home',
            icon: Icons.home,
          ),
          primary: true,
          debug: false,
          pageBuilder: (_) => const HomePage(),
        ),
        PageDefinition(
          pageInfo: const PageInfo(
            name: 'orders',
            title: 'Orders',
            icon: FontAwesomeIcons.bagShopping,
          ),
          primary: false,
          debug: true,
          pageBuilder: (_) => const OrdersPage(),
        ),
        PageDefinition(
          pageInfo: const PageInfo(
            name: 'products',
            title: 'Products',
            icon: FontAwesomeIcons.cube,
          ),
          primary: false,
          debug: true,
          pageBuilder: (_) => const ProductsPage(),
        ),
        PageDefinition(
          pageInfo: const PageInfo(
            name: 'notifications',
            title: 'Notifications',
            icon: FontAwesomeIcons.bell,
          ),
          primary: false,
          debug: true,
          pageBuilder: (_) => const NotificationsPage(),
        ),
        PageDefinition(
          pageInfo: const PageInfo(
            name: 'settings',
            title: 'Settings',
            icon: FontAwesomeIcons.gear,
          ),
          primary: false,
          debug: false,
          pageBuilder: (_) => const SettingsPage(),
        ),
      ],
    ),
  );
}
