import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wt_app_definition/app_definition.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold_examples/actions/action_one.dart';
import 'package:wt_app_scaffold_examples/actions/action_two.dart';
import 'package:wt_app_scaffold_examples/apps/pages/firebase_page.dart';
import 'package:wt_app_scaffold_examples/pages/async_example_page.dart';
import 'package:wt_app_scaffold_examples/pages/counter_app_page.dart';
import 'package:wt_app_scaffold_examples/pages/database_example_page.dart';
import 'package:wt_prototyping/prototyping.dart';

mixin AppOne {
  static final definition = AppDefinition.from(
    appDetails: AppDetails(
      name: 'applicationOne',
      title: 'Application One',
      subTitle: 'First application',
      iconPath: 'assets/avocado.png',
    ),
    swipeEnabled: true,
    includeAppBar: true,
    menuAction: (context) {
      HiddenDrawerOpener.of(context)?.open();
    },
    profilePage: PageDefinition(
      info: PageInfo(
        name: 'profile',
        title: 'Profile',
        icon: Icons.person,
        itemType: ItemType.primary,
      ),
      pageBuilder: (pageContext) => const PlaceholderPage(title: 'Profile Screen'),
      showAppBar: true,
    ),
    pages: [
      PageDefinition(
        info: PageInfo(
          name: 'landingPage',
          title: 'Landing Page',
          icon: FontAwesomeIcons.clipboard,
          itemType: ItemType.primary,
          landing: true,
        ),
        pageType: AppScaffoldPageType.transparentCard,
        pageBuilder: (pageContext) => const FirebasePage(),
        showBottomMenu: false,
      ),
      PageDefinition(
        info: PageInfo(
          name: 'pageOne',
          title: 'Page One',
          icon: FontAwesomeIcons.clipboard,
          itemType: ItemType.primary,
          debug: true,
        ),
        pageBuilder: (pageContext) => BottomDrawerPage(
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
        info: PageInfo(
          name: 'pageTwo',
          title: 'Page Two',
          icon: FontAwesomeIcons.bagShopping,
          itemType: ItemType.secondary,
        ),
        pageType: AppScaffoldPageType.transparentCard,
        pageBuilder: (pageContext) {
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
        info: PageInfo(
          name: 'pageThree',
          title: 'Page Three',
          icon: FontAwesomeIcons.boxesPacking,
          debug: true,
        ),
        pageBuilder: (_) => const PlaceholderPage(title: 'Page Three'),
      ),
      PageDefinition(
        info: PageInfo(
          name: 'pageFour',
          title: 'Page Four',
          icon: FontAwesomeIcons.tractor,
          itemType: ItemType.primary,
          debug: true,
        ),
        pageBuilder: (_) => const PlaceholderPage(title: 'Page Four'),
      ),
      PageDefinition(
        info: PageInfo(
          name: 'counter',
          title: 'Counter',
          icon: Icons.settings,
          itemType: ItemType.primary,
        ),
        pageType: AppScaffoldPageType.transparentCard,
        pageBuilder: (_) => const CounterAppPage(title: 'Counter App'),
      ),
      PageDefinition(
        info: PageInfo(
          name: 'database',
          title: 'Database',
          icon: FontAwesomeIcons.database,
          itemType: ItemType.secondary,
        ),
        pageBuilder: (_) => const DatabaseExamplePage(),
      ),
      PageDefinition(
        info: PageInfo(
          name: 'async',
          title: 'Async',
          icon: FontAwesomeIcons.arrowsRotate,
          itemType: ItemType.secondary,
        ),
        pageBuilder: (_) => const AsyncExamplePage(),
      ),
      PageDefinition(
        info: PageInfo(
          name: 'settings',
          title: 'Settings',
          icon: Icons.settings,
          itemType: ItemType.primary,
        ),
        pageType: AppScaffoldPageType.transparentCard,
        pageBuilder: (pageContext) => AppScaffoldSettingsPage(
          backgroundColor: Colors.transparent,
          children: [
            ElevatedButton(
              onPressed: () {
                pageContext.ref.read(AppScaffoldStore.router).go('/');
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
      PageDefinition(
        info: PageInfo(
          name: 'pageFive',
          title: 'Page Five',
          icon: FontAwesomeIcons.car,
          itemType: ItemType.primary,
          debug: true,
        ),
        pageBuilder: (_) => const PlaceholderPage(title: 'Page Five'),
      ),
    ],
  );

  static AppStyles styles(Ref ref) => SharedAppConfig.styles(ref);
}
