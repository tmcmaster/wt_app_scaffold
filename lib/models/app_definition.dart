import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/widgets/placeholder_page.dart';

class AppDefinition {
  final String appTitle;
  final String appName;
  final AlwaysAliveProviderBase<AppDetails>? appDetailsProvider;

  final PageDefinition profilePage;
  final bool swipeEnabled;
  final List<PageDefinition> pages;

  final bool includeAppBar;
  final void Function(BuildContext context)? dismissAction;
  final void Function(BuildContext context)? menuAction;
  final List<LocalizationsDelegate>? localizationDelegates;
  final ApplicationType? applicationType;
  final ThemeMode? themeMode;
  final Color? colorScheme;
  final List<LocalizationsDelegate>? intlDelegates;
  final Set<Locale>? inltLocales;

  const AppDefinition._({
    required this.appTitle,
    required this.appName,
    required this.appDetailsProvider,
    required this.profilePage,
    required this.pages,
    required this.swipeEnabled,
    required this.includeAppBar,
    required this.dismissAction,
    required this.menuAction,
    required this.localizationDelegates,
    this.applicationType,
    this.themeMode,
    this.colorScheme,
    this.inltLocales,
    this.intlDelegates,
  });

  factory AppDefinition.from({
    required String appTitle,
    required String appName,
    AlwaysAliveProviderBase<AppDetails>? appDetailsProvider,
    PageDefinition? profilePage,
    required List<PageDefinition> pages,
    bool swipeEnabled = true,
    bool includeAppBar = false,
    void Function(BuildContext context)? dismissAction,
    void Function(BuildContext context)? menuAction,
    List<LocalizationsDelegate>? localizationDelegates,
    ApplicationType? applicationType,
    ThemeMode? themeMode,
    Color? colorScheme,
    List<LocalizationsDelegate>? intlDelegates,
    Set<Locale>? inltLocales,
  }) {
    return AppDefinition._(
      appTitle: appTitle,
      appName: appName,
      appDetailsProvider: appDetailsProvider,
      profilePage: profilePage ??
          PageDefinition(
            title: 'Profile',
            icon: Icons.person,
            builder: (_, __, ___) => const PlaceholderPage(title: 'Profile'),
          ),
      pages: pages,
      swipeEnabled: swipeEnabled,
      includeAppBar: includeAppBar,
      dismissAction: dismissAction,
      menuAction: menuAction,
      localizationDelegates: localizationDelegates,
      applicationType: applicationType,
      themeMode: themeMode,
      colorScheme: colorScheme,
      inltLocales: inltLocales,
      intlDelegates: intlDelegates,
    );
  }
}
