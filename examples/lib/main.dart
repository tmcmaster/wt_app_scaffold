import 'package:firepod/firebase_init.dart';
import 'package:sample_app/pages/counter_app_page.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';

import 'firebase_options.dart';

void main() async {
  final appDefinition = AppDefinition.from(
    appTitle: 'Demo Application',
    appName: 'demoApp',
    appDetails: AppDetails(
      title: 'Demo App',
      subTitle: 'site one',
      iconPath: 'assets/avocado.png',
    ),
    swipeEnabled: true,
    debugMode: true,
    loginSupport: const LoginSupport(
      emailEnabled: true,
      googleEnabled: true,
    ),
    appDetailsProvider: null,
    logoutAction: ActionDefinition(
      title: 'Logout',
      icon: Icons.logout,
      onTap: (context) {
        // TODO: Should remove this action, and let the app template manage it.
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
        debug: false,
        builder: (context) => const PlaceholderPage(
          title: 'Orders',
        ),
      ),
      PageDefinition(
        title: 'Products',
        icon: FontAwesomeIcons.bagShopping,
        debug: false,
        builder: (context) => const PlaceholderPage(title: 'Products'),
      ),
      PageDefinition(
        title: 'Packing Sheets',
        icon: FontAwesomeIcons.boxesPacking,
        debug: true,
        builder: (context) => const PlaceholderPage(title: 'Packing Sheets'),
      ),
      PageDefinition(
        title: 'Harvest List',
        icon: FontAwesomeIcons.tractor,
        debug: true,
        builder: (context) => const PlaceholderPage(title: 'Harvest List'),
      ),
      PageDefinition(
        title: 'Delivery Routes',
        icon: FontAwesomeIcons.car,
        debug: true,
        builder: (context) => const PlaceholderPage(title: 'Delivery Routes'),
      ),
      PageDefinition(
        title: 'Counter',
        icon: Icons.settings,
        primary: true,
        builder: (context) => const CounterAppPage(title: 'Counter App'),
      ),
      PageDefinition(
        title: 'Settings',
        icon: Icons.settings,
        primary: true,
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
  );

  runMyApp(
    withFirebase(
      andAppScaffold(
        appDefinition,
      ),
      appName: 'wt-app-scaffold',
      firebaseOptions: DefaultFirebaseOptions.currentPlatform,
    ),
  );
}
