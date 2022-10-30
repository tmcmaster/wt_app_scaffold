import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/widgets/placeholder_page.dart';
import 'package:wt_app_scaffold_examples/actions/action_one.dart';
import 'package:wt_app_scaffold_examples/actions/action_two.dart';
import 'package:wt_app_scaffold_examples/pages/counter_app_page.dart';
import 'package:wt_firepod/wt_firepod.dart';

import 'firebase_options.dart';

final appDefinition = Provider<AppDefinition>(
  name: 'Application Definition',
  (ref) => AppDefinition.from(
    appTitle: 'Demo Application',
    appName: 'demoApp',
    appDetails: AppDetails(
      title: 'Demo App',
      subTitle: 'site one',
      iconPath: 'assets/avocado.png',
    ),
    swipeEnabled: true,
    debugMode: true,
    appDetailsProvider: null,
    profilePage: PageDefinition(
      icon: Icons.person,
      title: 'Profile',
      builder: (context) => const PlaceholderPage(
        title: 'Profile',
      ),
    ),
    pages: [
      PageDefinition(
        title: 'Page One',
        icon: FontAwesomeIcons.clipboard,
        debug: false,
        builder: (context) => BottomDrawerPage(
          mainWidget: const Center(
            child: Text('Page One'),
          ),
          drawWidget: const Center(
            child: Text('Page One Controls'),
          ),
          includeAppBar: true,
          action: ref.read(ActionOne.provider),
          actions: [ref.read(ActionTwo.provider)],
        ),
      ),
      PageDefinition(
        title: 'Page Two',
        icon: FontAwesomeIcons.bagShopping,
        debug: false,
        builder: (context) => const PlaceholderPage(title: 'Page Two'),
      ),
      PageDefinition(
        title: 'Page Three',
        icon: FontAwesomeIcons.boxesPacking,
        debug: true,
        builder: (context) => const PlaceholderPage(title: 'PAge Three'),
      ),
      PageDefinition(
        title: 'Page Fouur',
        icon: FontAwesomeIcons.tractor,
        debug: true,
        builder: (context) => const PlaceholderPage(title: 'Page Four'),
      ),
      PageDefinition(
        title: 'Page Five',
        icon: FontAwesomeIcons.car,
        debug: true,
        builder: (context) => const PlaceholderPage(title: 'Page Five'),
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
  ),
);

void main() async {
  runMyApp(
    withFirebase(
      andAppScaffold(
          appDefinition: appDefinition,
          loginSupport: const LoginSupport(
            emailEnabled: true,
            googleEnabled: true,
          )),
      appName: 'wt-app-scaffold',
      firebaseOptions: DefaultFirebaseOptions.currentPlatform,
    ),
  );
}
