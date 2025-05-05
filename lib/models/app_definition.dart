import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/models/page_info.dart';
import 'package:wt_app_scaffold/models/scaffold_page_type.dart';
import 'package:wt_app_scaffold/widgets/placeholder_page.dart';

class AppDefinition {
  final String appTitle;
  final String appName;
  final ProviderBase<AppDetails>? appDetailsProvider;

  final PageDefinition profilePage;
  final bool swipeEnabled;
  final List<PageDefinition> pages;

  final bool includeAppBar;
  final void Function(BuildContext context)? dismissAction;
  final void Function(BuildContext context)? menuAction;
  final List<LocalizationsDelegate>? localizationDelegates;
  final ApplicationType? applicationType;
  final ScaffoldPageType? scaffoldPageType;
  final ThemeMode? themeMode;
  final Color? colorScheme;
  final List<LocalizationsDelegate> intlDelegates;
  final Set<Locale>? intlLocales;

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
    this.scaffoldPageType,
    this.themeMode,
    this.colorScheme,
    this.intlLocales,
    this.intlDelegates = const <LocalizationsDelegate>[],
  });

  factory AppDefinition.from({
    required String appTitle,
    required String appName,
    ProviderBase<AppDetails>? appDetailsProvider,
    PageDefinition? profilePage,
    required List<PageDefinition> pages,
    bool swipeEnabled = true,
    bool includeAppBar = false,
    void Function(BuildContext context)? dismissAction,
    void Function(BuildContext context)? menuAction,
    List<LocalizationsDelegate>? localizationDelegates,
    ApplicationType? applicationType,
    ScaffoldPageType? scaffoldPageType,
    ThemeMode? themeMode,
    Color? colorScheme,
    List<LocalizationsDelegate> intlDelegates = const <LocalizationsDelegate>[],
    Set<Locale>? intlLocales,
  }) {
    return AppDefinition._(
      appTitle: appTitle,
      appName: appName,
      appDetailsProvider: appDetailsProvider,
      profilePage: profilePage ??
          PageDefinition(
            pageInfo: const PageInfo(
              title: 'Profile',
              name: 'profile',
              icon: Icons.person,
            ),
            pageBuilder: (_) => const PlaceholderPage(title: 'Profile'),
          ),
      pages: pages,
      swipeEnabled: swipeEnabled,
      includeAppBar: includeAppBar,
      dismissAction: dismissAction,
      menuAction: menuAction ??
          (context) {
            HiddenDrawerOpener.of(context)?.open();
          },
      localizationDelegates: localizationDelegates,
      applicationType: applicationType,
      scaffoldPageType: scaffoldPageType,
      themeMode: themeMode,
      colorScheme: colorScheme,
      intlLocales: intlLocales ?? {const Locale('en', '')},
      intlDelegates: intlDelegates,
    );
  }
}
