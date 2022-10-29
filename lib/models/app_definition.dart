import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/placeholder_page.dart';
import 'action_definition.dart';
import 'app_details.dart';
import 'page_definition.dart';

class AppDefinition {
  final String appTitle;
  final String appName;
  final AlwaysAliveProviderBase<AppDetails>? appDetailsProvider;
  final AppDetails? appDetails;

  final ActionDefinition logoutAction;
  final PageDefinition profilePage;
  final bool swipeEnabled;
  final List<PageDefinition> pages;

  // final bool debugMode;
  final bool includeAppBar;
  final void Function(BuildContext context)? dismissAction;
  final void Function(BuildContext context)? menuAction;
  final List<LocalizationsDelegate>? localizationDelegates;

  const AppDefinition._({
    required this.appTitle,
    required this.appName,
    required this.appDetailsProvider,
    required this.appDetails,
    required this.logoutAction,
    required this.profilePage,
    required this.pages,
    required this.swipeEnabled,
    required this.includeAppBar,
    // required this.debugMode,
    required this.dismissAction,
    required this.menuAction,
    required this.localizationDelegates,
  });

  factory AppDefinition.from({
    required String appTitle,
    required String appName,
    AlwaysAliveProviderBase<AppDetails>? appDetailsProvider,
    AppDetails? appDetails,
    ActionDefinition? logoutAction,
    PageDefinition? profilePage,
    required List<PageDefinition> pages,
    bool swipeEnabled = true,
    bool debugMode = true,
    bool includeAppBar = false,
    void Function(BuildContext context)? dismissAction,
    void Function(BuildContext context)? menuAction,
    List<LocalizationsDelegate>? localizationDelegates,
  }) {
    return AppDefinition._(
      appTitle: appTitle,
      appName: appName,
      appDetailsProvider: appDetailsProvider,
      appDetails: appDetails,
      logoutAction: logoutAction ?? ActionDefinition(title: 'Logout', icon: Icons.logout, onTap: (_) {}),
      profilePage: profilePage ??
          PageDefinition(
            title: 'Profile',
            icon: Icons.person,
            builder: (_) => PlaceholderPage(title: 'Profile'),
          ),
      pages: pages,
      swipeEnabled: swipeEnabled,
      // debugMode: debugMode,
      includeAppBar: includeAppBar,
      dismissAction: dismissAction,
      menuAction: menuAction,
      localizationDelegates: localizationDelegates,
    );
  }
}
