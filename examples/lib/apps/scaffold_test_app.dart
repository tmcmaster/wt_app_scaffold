import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wt_app_definition/app_definition.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';

mixin ScaffoldTestApp {
  static final definition = AppDefinition.from(
    appDetails: AppDetails(
      name: 'scaffoldTestApp',
      title: 'Scaffold Test App',
      subTitle: 'This is a sub-title',
      iconPath: 'assets/avocado.png',
    ),
    swipeEnabled: true,
    includeAppBar: true,
    profilePage: null,
    pages: [
      PageDefinition(
        info: PageInfo(
          name: 'landingPage',
          title: 'Landing Page',
          icon: FontAwesomeIcons.clipboard,
          itemType: ItemType.primary,
        ),
        pageType: AppScaffoldPageType.transparentCard,
        pageBuilder: (ctx) => PlaceholderPage(title: ctx.page.info.title),
        drawerBuilder: (ctx) => Container(),
      ),
      PageDefinition(
        info: PageInfo(
          name: 'anotherPage',
          title: 'Another Page',
          icon: FontAwesomeIcons.clipboard,
          itemType: ItemType.primary,
        ),
        pageType: AppScaffoldPageType.transparentCard,
        pageBuilder: (ctx) => PlaceholderPage(title: ctx.page.info.title),
      ),
    ],
  );

  static AppStyles styles(Ref ref) => SharedAppConfig.styles(ref);
}
