import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/models/definition/info/item_type.dart';
import 'package:wt_app_scaffold/models/definition/info/page_info.dart';
import 'package:wt_app_scaffold/widgets/placeholder_page.dart';
import 'package:wt_app_scaffold_examples/apps/chat_gpt/example_pages.dart';

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
        info: PageInfo(
          name: 'profile',
          title: 'Profile',
          icon: Icons.person,
          itemType: ItemType.primary,
        ),
        pageBuilder: (_) => const PlaceholderPage(
          title: 'Profile Screen',
        ),
      ),
      pages: [
        PageDefinition(
          info: PageInfo(
            name: 'home',
            title: 'Home',
            icon: Icons.home,
            itemType: ItemType.primary,
          ),
          pageBuilder: (_) => const HomePage(),
        ),
        PageDefinition(
          info: PageInfo(
            name: 'orders',
            title: 'Orders',
            icon: FontAwesomeIcons.bagShopping,
            itemType: ItemType.secondary,
            debug: true,
          ),
          pageBuilder: (_) => const OrdersPage(),
        ),
        PageDefinition(
          info: PageInfo(
            name: 'products',
            title: 'Products',
            icon: FontAwesomeIcons.cube,
            itemType: ItemType.secondary,
            debug: true,
          ),
          pageBuilder: (_) => const ProductsPage(),
        ),
        PageDefinition(
          info: PageInfo(
            name: 'notifications',
            title: 'Notifications',
            icon: FontAwesomeIcons.bell,
            itemType: ItemType.secondary,
            debug: true,
          ),
          pageBuilder: (_) => const NotificationsPage(),
        ),
        PageDefinition(
          info: PageInfo(
            name: 'settings',
            title: 'Settings',
            icon: FontAwesomeIcons.gear,
            itemType: ItemType.secondary,
          ),
          pageBuilder: (_) => const SettingsPage(),
        ),
      ],
    ),
  );
}
