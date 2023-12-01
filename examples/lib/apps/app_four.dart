import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/models/scaffold_page_type.dart';
import 'package:wt_app_scaffold/widgets/placeholder_page.dart';
import 'package:wt_app_scaffold_examples/apps/pages/navigation_page.dart';
import 'package:wt_app_scaffold_examples/apps/pages/plain_page.dart';
import 'package:wt_app_scaffold_examples/apps/pages/user_log_page.dart';
import 'package:wt_app_scaffold_examples/apps/widgets/authentication_butons.dart';
import 'package:wt_firepod/wt_firepod.dart';

mixin AppFour {
  static final details = AppDetails(
    title: 'Application Two',
    subTitle: 'Second application',
    iconPath: 'assets/avocado.png',
  );

  static final definition = AppDefinition.from(
    appTitle: 'Application Three',
    appName: 'appThree',
    swipeEnabled: true,
    includeAppBar: true,
    applicationType: ApplicationType.hiddenDrawer,
    pages: [
      PageDefinition(
        title: 'plain',
        icon: FontAwesomeIcons.faceSmile,
        primary: true,
        debug: false,
        builder: (_, __, ___, ____) => const PlainPage(),
        scaffoldType: ScaffoldPageType.transparentCard,
      ),
      PageDefinition(
        title: 'UserLog',
        icon: FontAwesomeIcons.bowlFood,
        primary: true,
        landing: true,
        debug: false,
        builder: (_, __, ___, ____) => const UserLogPage(),
        scaffoldType: ScaffoldPageType.transparentCard,
      ),
      PageDefinition(
        title: 'Navigation',
        icon: FontAwesomeIcons.bars,
        primary: true,
        debug: false,
        builder: (_, __, ___, ____) => const NavigationPage(
          routeTo: '/settings',
        ),
        scaffoldType: ScaffoldPageType.transparentCard,
      ),
      PageDefinition(
        title: 'Theme',
        icon: Icons.style,
        debug: true,
        primary: true,
        builder: (_, __, ___, ____) => const ThemePreviewScreen(),
        scaffoldType: ScaffoldPageType.transparentCard,
      ),
      PageDefinition(
        title: 'Settings',
        icon: Icons.settings,
        primary: true,
        builder: (context, __, ___, ____) => Padding(
          padding: const EdgeInsets.all(12),
          child: SettingsPage(
            backgroundColor: Colors.transparent,
            children: [
              if (FirepodFeatures.isFirebaseAvailable())
                const AuthenticationButtons(),
              const AppVersion(),
            ],
          ),
        ),
        scaffoldType: ScaffoldPageType.transparentCard,
      ),
      PageDefinition(
        title: 'Debug',
        icon: FontAwesomeIcons.bug,
        debug: true,
        primary: true,
        builder: (_, __, ___, ____) => const PlaceholderPage(
          title: 'Debug Mode Page',
          backgroundColor: Colors.transparent,
        ),
        scaffoldType: ScaffoldPageType.transparentCard,
      ),
      PageDefinition(
        title: 'Debug 2',
        icon: FontAwesomeIcons.bug,
        debug: true,
        primary: false,
        builder: (_, __, ___, ____) =>
            const PlaceholderPage(title: 'Debug Mode Page 2'),
        scaffoldType: ScaffoldPageType.transparentCard,
      ),
      PageDefinition(
        title: 'Debug 3',
        icon: FontAwesomeIcons.bug,
        debug: true,
        primary: false,
        builder: (_, __, ___, ____) =>
            const PlaceholderPage(title: 'Debug Mode Page 3'),
        scaffoldType: ScaffoldPageType.transparentCard,
      ),
      PageDefinition(
        title: 'Debug 4',
        icon: FontAwesomeIcons.bug,
        debug: true,
        primary: false,
        builder: (_, __, ___, ____) => const PlaceholderPage(
          title: 'Debug Mode Page 4',
          backgroundColor: Colors.transparent,
        ),
        scaffoldType: ScaffoldPageType.transparentCard,
      ),
    ],
  );

  static final styles = HiddenDrawerApp.styles;
}
