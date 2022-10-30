import 'package:firepod/firebase_init.dart';
import 'package:sample_app/pages/counter_app_page.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/init/app_scaffold_init.dart';
import 'package:wt_app_scaffold/models/app_definition.dart';
import 'package:wt_app_scaffold/scaffolds/page/bottom_drawer_page/settings_page.dart';

import 'firebase_options.dart';

void main() async {
  runMyApp(
    withFirebase(
        andAppScaffold(AppDefinition.from(
          appTitle: 'Demo Application',
          appName: 'demoApp',
          appDetails: AppDetails(
            title: 'Demo App',
            subTitle: 'site one',
            iconPath: 'assets/avocado.png',
          ),
          swipeEnabled: true,
          debugMode: true,
          loginProviders: const LoginSupport(
            emailEnabled: true,
            googleEnabled: true,
          ),
          appDetailsProvider: null,
          logoutAction: ActionDefinition(
            title: 'Logout',
            icon: Icons.logout,
            onTap: (_) {
              print('Logging out user');
            },
          ),
          profilePage: PageDefinition(
            icon: Icons.person,
            title: 'Profile',
            builder: (context) => const PlaceholderPage(
              title: 'Profile',
            ),
          ),
          pages: [
            PageDefinition(
              title: 'Orders',
              icon: FontAwesomeIcons.clipboard,
              builder: (context) => const PlaceholderPage(
                title: 'Orders',
              ),
            ),
            PageDefinition(
              title: 'Products',
              icon: FontAwesomeIcons.bagShopping,
              builder: (context) => const PlaceholderPage(title: 'Products'),
            ),
            PageDefinition(
              title: 'Packing Sheets',
              icon: FontAwesomeIcons.boxesPacking,
              builder: (context) => const PlaceholderPage(title: 'Packing Sheets'),
            ),
            PageDefinition(
              title: 'Harvest List',
              icon: FontAwesomeIcons.tractor,
              builder: (context) => const PlaceholderPage(title: 'Harvest List'),
            ),
            PageDefinition(
              title: 'Delivery Routes',
              icon: FontAwesomeIcons.car,
              builder: (context) => const PlaceholderPage(title: 'Delivery Routes'),
            ),
            PageDefinition(
              title: 'Counter',
              icon: Icons.settings,
              builder: (context) => const CounterAppPage(title: 'Counter App'),
            ),
            PageDefinition(
              title: 'Settings',
              icon: Icons.settings,
              builder: (context) => SettingsPage(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("/");
                      },
                      child: const Text('Login'))
                ],
              ),
            ),
          ],
        )),
        appName: 'wt-app-scaffold',
        firebaseOptions: DefaultFirebaseOptions.currentPlatform),
  );
}
