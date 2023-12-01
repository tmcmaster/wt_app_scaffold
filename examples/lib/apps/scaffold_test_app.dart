import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/models/scaffold_page_type.dart';
import 'package:wt_app_scaffold_examples/apps/pages/landing_page.dart';
import 'package:wt_app_scaffold_examples/apps/widgets/test_web_view.dart';

mixin ScaffoldTestApp {
  static final details = AppDetails(
    title: 'Scaffold Test App',
    subTitle: 'This is a sub-title',
    iconPath: 'assets/avocado.png',
  );

  static final definition = AppDefinition.from(
    appTitle: 'Scaffold Test App',
    appName: 'scaffoldTestApp',
    swipeEnabled: true,
    includeAppBar: true,
    profilePage: null,
    applicationType: ApplicationType.goRouterMenu,
    pages: [
      PageDefinition(
        title: 'Landing Page',
        icon: FontAwesomeIcons.clipboard,
        primary: true,
        scaffoldType: ScaffoldPageType.transparentCard,
        builder: (context, _, __, ____) => const LandingPage(),
        drawerBuilder: (context) => Container(),
      ),
      PageDefinition(
        title: 'Another Page',
        icon: FontAwesomeIcons.clipboard,
        primary: true,
        scaffoldType: ScaffoldPageType.transparentCard,
        builder: (context, _, __, ____) => const TestWebView(),
      ),
    ],
  );

  static final styles = GoRouterMenuApp.styles;
}
