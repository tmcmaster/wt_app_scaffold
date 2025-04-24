import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wt_app_scaffold/app_platform/util/app_scaffold_router.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/models/app_styles.dart';
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
    applicationType: ApplicationType.hiddenDrawer,
    menuAction: (context) {
      HiddenDrawerOpener.of(context)?.open();
    },
    profilePage: PageDefinition(
      icon: Icons.person,
      title: 'Profile',
      primary: true,
      builder: (pageContext) => const PlaceholderPage(title: 'Profile Screen'),
      showAppBar: true,
    ),
    pages: [
      PageDefinition(
        title: 'Landing Page',
        icon: FontAwesomeIcons.clipboard,
        primary: true,
        landing: true,
        debug: false,
        scaffoldType: ScaffoldPageType.transparentCard,
        builder: (pageContext) => const FirebasePage(),
        showBottomMenu: false,
      ),
      PageDefinition(
        title: 'Page One',
        primary: true,
        icon: FontAwesomeIcons.clipboard,
        debug: true,
        builder: (pageContext) => BottomDrawerPage(
          title: 'Page One',
          mainWidget: const Center(
            child: Text('Page One'),
          ),
          drawWidget: const Center(
            child: Text('Page One Controls'),
          ),
          includeAppBar: false,
          action: pageContext.ref.read(ActionOne.provider),
          actions: [
            pageContext.ref.read(ActionOne.provider),
            pageContext.ref.read(ActionTwo.provider),
          ],
        ),
      ),
      PageDefinition(
        title: 'Page Two',
        icon: FontAwesomeIcons.bagShopping,
        primary: false,
        debug: false,
        scaffoldType: ScaffoldPageType.transparentCard,
        builder: (pageContext) {
          final user = pageContext.ref.read(AppScaffoldAuthenticationStore.user);

          return PlaceholderPage(
            backgroundColor: Colors.transparent,
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
        builder: (_) => const PlaceholderPage(title: 'Page Three'),
      ),
      PageDefinition(
        title: 'Page Four',
        icon: FontAwesomeIcons.tractor,
        debug: true,
        builder: (_) => const PlaceholderPage(title: 'Page Four'),
      ),
      PageDefinition(
        title: 'Counter',
        icon: Icons.settings,
        scaffoldType: ScaffoldPageType.transparentCard,
        primary: true,
        builder: (_) => const CounterAppPage(title: 'Counter App'),
      ),
      PageDefinition(
        title: 'Database',
        icon: FontAwesomeIcons.database,
        primary: false,
        builder: (_) => const DatabaseExamplePage(),
      ),
      PageDefinition(
        title: 'Async',
        icon: FontAwesomeIcons.arrowsRotate,
        primary: false,
        builder: (_) => const AsyncExamplePage(),
      ),
      PageDefinition(
        title: 'Settings',
        icon: Icons.settings,
        primary: true,
        scaffoldType: ScaffoldPageType.transparentCard,
        builder: (pageContext) => SettingsPage(
          backgroundColor: Colors.transparent,
          children: [
            ElevatedButton(
              onPressed: () {
                pageContext.ref.read(AppScaffoldRouter.provider).go('/');
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
        builder: (_) => const PlaceholderPage(title: 'Page Five'),
      ),
    ],
  );

  static AppStyles styles(Ref ref) => SharedAppConfig.styles(ref);
}
