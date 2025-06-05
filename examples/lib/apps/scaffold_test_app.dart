import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/models/app_styles.dart';
import 'package:wt_app_scaffold/models/definition/info/page_info.dart';
import 'package:wt_app_scaffold/models/scaffold_page_type.dart';
import 'package:wt_app_scaffold/widgets/placeholder_page.dart';

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
        pageInfo: PageInfo(
          name: 'landingPage',
          title: 'Landing Page',
          icon: FontAwesomeIcons.clipboard,
        ),
        primary: true,
        scaffoldType: ScaffoldPageType.transparentCard,
        pageBuilder: (ctx) => PlaceholderPage(title: ctx.page.pageInfo.title),
        drawerBuilder: (ctx) => Container(),
      ),
      PageDefinition(
        pageInfo: PageInfo(
          name: 'anotherPage',
          title: 'Another Page',
          icon: FontAwesomeIcons.clipboard,
        ),
        primary: true,
        scaffoldType: ScaffoldPageType.transparentCard,
        pageBuilder: (ctx) => PlaceholderPage(title: ctx.page.pageInfo.title),
      ),
    ],
  );

  static AppStyles styles(Ref ref) => SharedAppConfig.styles(ref);
}
