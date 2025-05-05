import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/models/app_styles.dart';
import 'package:wt_app_scaffold/models/page_info.dart';
import 'package:wt_app_scaffold/models/scaffold_page_type.dart';
import 'package:wt_app_scaffold_examples/apps/pages/landing_page.dart';
// import 'package:wt_app_scaffold_examples/apps/widgets/test_web_view.dart';

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
        pageInfo: const PageInfo(
          name: 'landingPage',
          title: 'Landing Page',
          icon: FontAwesomeIcons.clipboard,
        ),
        primary: true,
        scaffoldType: ScaffoldPageType.transparentCard,
        pageBuilder: (_) => const LandingPage(),
        drawerBuilder: (context) => Container(),
      ),
      // Example migration for the commented-out page:
      // PageDefinition(
      //   pageInfo: const PageInfo(
      //     name: 'anotherPage',
      //     title: 'Another Page',
      //     icon: FontAwesomeIcons.clipboard,
      //   ),
      //   primary: true,
      //   scaffoldType: ScaffoldPageType.transparentCard,
      //   pageBuilder: (_) => const TestWebView(),
      // ),
    ],
  );

  static AppStyles styles(Ref ref) => SharedAppConfig.styles(ref);
}
