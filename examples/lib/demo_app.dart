import 'package:firepod/login/firebase_auth_ui_example.dart';
import 'package:sample_app/pages/counter_app_page.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/scaffolds/page/bottom_drawer_page/settings_page.dart';

class DemoApp extends ConsumerWidget {
  static final log = logger(DemoApp);

  static final appDetails = Provider<AppDetails>(
    name: 'DemoAppProviders.appDetails',
    (ref) {
      return AppDetails(
        title: 'Demo App',
        subTitle: 'site one',
        iconPath: 'assets/avocado.png',
      );
    },
  );

  const DemoApp({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.read(FirebaseSetup.instance.login.notifier);
    final debugMode = ref.watch(ApplicationSettings.debugMode.value);

    return AppContainer(
      appDefinition: AppDefinition.from(
        appTitle: 'Demo Application',
        appName: 'demoApp',
        appDetails: AppDetails(
          title: 'Demo App',
          subTitle: 'site one',
          iconPath: 'assets/avocado.png',
        ),
        swipeEnabled: true,
        debugMode: debugMode,
        logoutAction: ActionDefinition(
          title: 'Logout',
          icon: Icons.logout,
          onTap: (_) {
            print('Logging out user');
            auth.logout();
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
          // PageDefinition(
          //   title: 'Firebase Login',
          //   icon: Icons.login,
          //   builder: (context) => const FirebaseAuthUIExample(),
          // ),
          PageDefinition(
            title: 'Settings',
            icon: Icons.settings,
            builder: (context) => const SettingsPage(),
          ),
        ],
      ),
    );
  }
}
