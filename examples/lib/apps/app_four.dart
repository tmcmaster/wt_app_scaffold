import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wt_app_definition/app_definition.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold_examples/apps/pages/navigation_page.dart';
import 'package:wt_app_scaffold_examples/apps/pages/plain_page.dart';
import 'package:wt_app_scaffold_examples/apps/pages/user_log_page.dart';
import 'package:wt_app_scaffold_examples/apps/widgets/authentication_buttons.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_prototyping/prototyping.dart';

mixin AppFour {
  static final definition = AppDefinition.from(
    appDetails: AppDetails(
      name: 'applicationTwo',
      title: 'Application Two',
      subTitle: 'Second application',
      iconPath: 'assets/avocado.png',
    ),
    swipeEnabled: true,
    includeAppBar: true,
    pages: [
      PageDefinition(
        info: PageInfo(
          name: 'plain',
          title: 'Plain',
          icon: FontAwesomeIcons.faceSmile,
          itemType: ItemType.primary,
        ),
        pageBuilder: (_) => const PlainPage(),
        pageType: AppScaffoldPageType.transparentCard,
      ),
      PageDefinition(
        info: PageInfo(
          name: 'userLog',
          title: 'UserLog',
          icon: FontAwesomeIcons.bowlFood,
          itemType: ItemType.primary,
          landing: true,
        ),
        pageBuilder: (_) => const UserLogPage(),
        pageType: AppScaffoldPageType.transparentCard,
      ),
      PageDefinition(
        info: PageInfo(
          name: 'navigation',
          title: 'Navigation',
          icon: FontAwesomeIcons.bars,
          itemType: ItemType.primary,
        ),
        pageBuilder: (_) => const NavigationPage(
          routeTo: '/settings',
        ),
        pageType: AppScaffoldPageType.transparentCard,
      ),
      PageDefinition(
        info: PageInfo(
          name: 'theme',
          title: 'Theme',
          icon: Icons.style,
          debug: true,
          itemType: ItemType.primary,
        ),
        pageBuilder: (_) => const ThemePreviewScreen(),
        pageType: AppScaffoldPageType.transparentCard,
      ),
      PageDefinition(
        info: PageInfo(
          name: 'settings',
          title: 'Settings',
          icon: Icons.settings,
          itemType: ItemType.primary,
        ),
        pageBuilder: (_) => Padding(
          padding: const EdgeInsets.all(12),
          child: AppScaffoldSettingsPage(
            backgroundColor: Colors.transparent,
            children: [
              if (FirepodFeatures.isFirebaseAvailable()) const AuthenticationButtons(),
              const AppVersion(),
            ],
          ),
        ),
        pageType: AppScaffoldPageType.transparentCard,
      ),
      PageDefinition(
        info: PageInfo(
          name: 'debug',
          title: 'Debug',
          icon: FontAwesomeIcons.bug,
          itemType: ItemType.primary,
          debug: true,
        ),
        pageBuilder: (_) => const PlaceholderPage(
          title: 'Debug Mode Page',
          backgroundColor: Colors.transparent,
        ),
        pageType: AppScaffoldPageType.transparentCard,
      ),
      PageDefinition(
        info: PageInfo(
          name: 'debug2',
          title: 'Debug 2',
          icon: FontAwesomeIcons.bug,
          itemType: ItemType.primary,
          debug: true,
        ),
        pageBuilder: (_) => const PlaceholderPage(title: 'Debug Mode Page 2'),
        pageType: AppScaffoldPageType.transparentCard,
      ),
      PageDefinition(
        info: PageInfo(
          name: 'debug3',
          title: 'Debug 3',
          icon: FontAwesomeIcons.bug,
          itemType: ItemType.primary,
          debug: true,
        ),
        pageBuilder: (_) => const PlaceholderPage(title: 'Debug Mode Page 3'),
        pageType: AppScaffoldPageType.transparentCard,
      ),
      PageDefinition(
        info: PageInfo(
          name: 'debug4',
          title: 'Debug 4',
          icon: FontAwesomeIcons.bug,
          itemType: ItemType.primary,
          debug: true,
        ),
        pageBuilder: (_) => const PlaceholderPage(
          title: 'Debug Mode Page 4',
          backgroundColor: Colors.transparent,
        ),
        pageType: AppScaffoldPageType.transparentCard,
      ),
    ],
  );

  static AppStyles styles(Ref ref) => SharedAppConfig.styles(ref);
}
