import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wt_app_scaffold/app_platform/auth/app_scaffold_authentication.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/models/scaffold_page_type.dart';
import 'package:wt_app_scaffold/widgets/placeholder_page.dart';
import 'package:wt_app_scaffold_examples/actions/action_one.dart';
import 'package:wt_app_scaffold_examples/actions/action_two.dart';
import 'package:wt_app_scaffold_examples/apps/pages/firebase_page.dart';
import 'package:wt_app_scaffold_examples/pages/async_example_page.dart';
import 'package:wt_app_scaffold_examples/pages/counter_app_page.dart';
import 'package:wt_app_scaffold_examples/pages/database_example_page.dart';

mixin AppOne {
  static final details = AppDetails(
    title: 'Application One',
    subTitle: 'First application',
    iconPath: 'assets/avocado.png',
  );

  static final definition = AppDefinition.from(
    appTitle: 'Application One',
    appName: 'appOne',
    swipeEnabled: true,
    includeAppBar: true,
    // applicationType: ApplicationType.hiddenDrawer,
    profilePage: PageDefinition(
      icon: Icons.person,
      title: 'Profile',
      primary: true,
      builder: (context, _, __, ____) =>
          const PlaceholderPage(title: 'Profile Screen'),
    ),
    pages: [
      PageDefinition(
        title: 'Landing Page',
        icon: FontAwesomeIcons.clipboard,
        primary: true,
        landing: true,
        debug: false,
        scaffoldType: ScaffoldPageType.transparentCard,
        builder: (context, _, __, ____) => const FirebasePage(),
      ),
      PageDefinition(
        title: 'Page One',
        primary: true,
        icon: FontAwesomeIcons.clipboard,
        debug: true,
        builder: (context, ref, __, ____) => BottomDrawerPage(
          title: 'Page One',
          mainWidget: const Center(
            child: Text('Page One'),
          ),
          drawWidget: const Center(
            child: Text('Page One Controls'),
          ),
          includeAppBar: false,
          action: ref.read(ActionOne.provider),
          actions: [
            ref.read(ActionOne.provider),
            ref.read(ActionTwo.provider),
          ],
        ),
      ),
      PageDefinition(
        title: 'Page Two',
        icon: FontAwesomeIcons.bagShopping,
        primary: false,
        debug: false,
        builder: (_, ref, ___, ____) {
          final user = ref.read(AppScaffoldAuthenticationStore.user);

          return PlaceholderPage(
            title: 'Page Two',
            children: [
              Text('Id: ${user.id}'),
              Text('name: ${user.name}'),
              Text('email: ${user.email}'),
            ],
          );
        },
      ),
      PageDefinition(
        title: 'Page Three',
        icon: FontAwesomeIcons.boxesPacking,
        debug: true,
        builder: (_, __, ___, ____) =>
            const PlaceholderPage(title: 'Page Three'),
      ),
      PageDefinition(
        title: 'Page Four',
        icon: FontAwesomeIcons.tractor,
        debug: true,
        builder: (_, __, ___, ____) =>
            const PlaceholderPage(title: 'Page Four'),
      ),
      PageDefinition(
        title: 'Counter',
        icon: Icons.settings,
        scaffoldType: ScaffoldPageType.transparentCard,
        primary: true,
        builder: (_, __, ___, ____) =>
            const CounterAppPage(title: 'Counter App'),
      ),
      PageDefinition(
        title: 'Database',
        icon: FontAwesomeIcons.database,
        primary: false,
        builder: (_, __, ___, ____) => const DatabaseExamplePage(),
      ),
      PageDefinition(
        title: 'Async',
        icon: FontAwesomeIcons.arrowsRotate,
        primary: false,
        builder: (_, __, ___, ____) => const AsyncExamplePage(),
      ),
      PageDefinition(
        title: 'Settings',
        icon: Icons.settings,
        primary: true,
        scaffoldType: ScaffoldPageType.transparentCard,
        builder: (context, _, __, ____) => SettingsPage(
          backgroundColor: Colors.transparent,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/');
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
      PageDefinition(
        title: 'Page Five',
        icon: FontAwesomeIcons.car,
        debug: true,
        primary: true,
        builder: (_, __, ___, ____) =>
            const PlaceholderPage(title: 'Page Five'),
      ),
    ],
  );

  static final styles = GoRouterMenuApp.styles;
}
