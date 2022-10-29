import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/widgets/placeholder_page.dart';

class DemoApp {
  static final definition = AppDefinition.from(
    appTitle: 'Demo Application',
    appName: 'demoApp',
    appDetails: AppDetails(
      title: 'App Title',
      subTitle: 'SubTitle',
      iconPath: 'avocado.png',
    ),
    swipeEnabled: true,
    logoutAction: ActionDefinition(
      title: 'Logout',
      icon: Icons.logout,
      onTap: (_) {},
    ),
    profilePage: PageDefinition(
      icon: Icons.person,
      title: 'Profile',
      builder: (context) => PlaceholderPage(
        title: 'Profile',
      ),
    ),
    pages: [
      PageDefinition(
        title: 'Orders',
        icon: FontAwesomeIcons.clipboard,
        builder: (context) => PlaceholderPage(
          title: 'Orders',
        ),
      ),
      PageDefinition(
        title: 'Products',
        icon: FontAwesomeIcons.bagShopping,
        builder: (context) => PlaceholderPage(title: 'Products'),
      ),
      PageDefinition(
        title: 'Packing Sheets',
        icon: FontAwesomeIcons.boxesPacking,
        builder: (context) => PlaceholderPage(title: 'Packing Sheets'),
      ),
      PageDefinition(
        title: 'Harvest List',
        icon: FontAwesomeIcons.tractor,
        builder: (context) => PlaceholderPage(title: 'Harvest List'),
      ),
      PageDefinition(
        title: 'Delivery Routes',
        icon: FontAwesomeIcons.car,
        builder: (context) => PlaceholderPage(title: 'Delivery Routes'),
      ),
      PageDefinition(
        title: 'Settings',
        icon: Icons.settings,
        builder: (context) => PlaceholderPage(title: 'Settings'),
      ),
    ],
  );
}
