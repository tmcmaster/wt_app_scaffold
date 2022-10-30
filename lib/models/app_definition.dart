import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/action_button_definition.dart';

import '../widgets/placeholder_page.dart';
import 'app_details.dart';
import 'login_support.dart';
import 'page_definition.dart';

class AppDefinition {
  final String appTitle;
  final String appName;
  final AlwaysAliveProviderBase<AppDetails>? appDetailsProvider;
  final AppDetails? appDetails;

  final PageDefinition profilePage;
  final bool swipeEnabled;
  final List<PageDefinition> pages;

  // final bool debugMode;
  final bool includeAppBar;
  final void Function(BuildContext context)? dismissAction;
  final void Function(BuildContext context)? menuAction;
  final List<LocalizationsDelegate>? localizationDelegates;

  final LoginSupport loginSupport;

  const AppDefinition._({
    required this.appTitle,
    required this.appName,
    required this.appDetailsProvider,
    required this.appDetails,
    required this.profilePage,
    required this.pages,
    required this.swipeEnabled,
    required this.includeAppBar,
    // required this.debugMode,
    required this.dismissAction,
    required this.menuAction,
    required this.localizationDelegates,
    required this.loginSupport,
  });

  factory AppDefinition.from({
    required String appTitle,
    required String appName,
    AlwaysAliveProviderBase<AppDetails>? appDetailsProvider,
    AppDetails? appDetails,
    ActionButtonDefinition? logoutAction,
    PageDefinition? profilePage,
    required List<PageDefinition> pages,
    bool swipeEnabled = true,
    bool debugMode = true,
    bool includeAppBar = false,
    void Function(BuildContext context)? dismissAction,
    void Function(BuildContext context)? menuAction,
    List<LocalizationsDelegate>? localizationDelegates,
    LoginSupport loginSupport = LoginSupport.none,
  }) {
    return AppDefinition._(
      appTitle: appTitle,
      appName: appName,
      appDetailsProvider: appDetailsProvider,
      appDetails: appDetails,
      profilePage: profilePage ??
          PageDefinition(
            title: 'Profile',
            icon: Icons.person,
            builder: (_) => const PlaceholderPage(title: 'Profile'),
          ),
      pages: pages,
      swipeEnabled: swipeEnabled,
      // debugMode: debugMode,
      includeAppBar: includeAppBar,
      dismissAction: dismissAction,
      menuAction: menuAction,
      localizationDelegates: localizationDelegates,
      loginSupport: loginSupport,
    );
  }
}
