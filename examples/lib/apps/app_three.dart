import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wt_app_scaffold/app_platform/app_scaffold_features.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/models/app_styles.dart';
import 'package:wt_app_scaffold/widgets/placeholder_page.dart';
import 'package:wt_app_scaffold_examples/apps/pages/navigation_page.dart';
import 'package:wt_app_scaffold_examples/apps/pages/plain_page.dart';
import 'package:wt_app_scaffold_examples/apps/pages/snack_bar_page.dart';
import 'package:wt_firepod/wt_firepod.dart';

mixin AppThree {
  static final details = Provider<AppDetails>(
    name: 'AppThree Details',
    (ref) => AppDetails(
      title: 'Application Two',
      subTitle: 'Second application',
      iconPath: 'assets/avocado.png',
    ),
  );

  static final definition = Provider<AppDefinition>(
    name: 'AppTwo Definition',
    (ref) => AppDefinition.from(
      appTitle: 'Application Three',
      appName: 'appThree',
      swipeEnabled: true,
      includeAppBar: true,
      appDetailsProvider: details,
      applicationType: ApplicationType.bottomNavBar,
      pages: [
        PageDefinition(
          title: 'Plain',
          icon: FontAwesomeIcons.clipboard,
          primary: true,
          debug: false,
          builder: (_, __, ___) => const PlainPage(),
          scaffoldType: ScaffoldType.transparentCard,
        ),
        PageDefinition(
          title: 'SnackBar',
          icon: FontAwesomeIcons.clipboard,
          primary: true,
          landing: true,
          debug: false,
          builder: (_, __, ___) => const SnackBarPage(),
          scaffoldType: ScaffoldType.transparentCard,
        ),
        PageDefinition(
          title: 'Navigation',
          icon: FontAwesomeIcons.bars,
          primary: true,
          debug: false,
          builder: (_, __, ___) => const NavigationPage(
            routeTo: '/settings',
          ),
          scaffoldType: ScaffoldType.transparentCard,
        ),
        PageDefinition(
          title: 'Theme',
          icon: Icons.style,
          debug: true,
          primary: true,
          builder: (_, __, ___) => const ThemePreviewScreen(),
          scaffoldType: ScaffoldType.transparentCard,
        ),
        PageDefinition(
          title: 'Settings',
          icon: Icons.settings,
          primary: true,
          builder: (context, __, ___) => Padding(
            padding: const EdgeInsets.all(12),
            child: SettingsPage(
              backgroundColor: Colors.transparent,
              children: [
                if (AppScaffoldFeatures.loginIsAvailable(context))
                  const AuthenticationButtons(),
                const AppVersion(),
              ],
            ),
          ),
          scaffoldType: ScaffoldType.transparentCard,
        ),
        PageDefinition(
          title: 'Debug',
          icon: FontAwesomeIcons.bug,
          debug: true,
          primary: true,
          builder: (_, __, ___) =>
              const PlaceholderPage(title: 'Debug Mode Page'),
          scaffoldType: ScaffoldType.transparentCard,
        ),
      ],
    ),
  );

  static final styles = Provider<AppStyles>(
    name: 'AppTwo Styles',
    (ref) => HiddenDrawerApp.styles,
  );
}

class AuthenticationButtons extends ConsumerWidget {
  const AuthenticationButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Wrap(
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/');
          },
          child: const Text('Login'),
        ),
        ElevatedButton(
          onPressed: () {
            ref.read(FirebaseProviders.auth).signOut();
          },
          child: const Text('Logout'),
        ),
      ],
    );
  }
}
