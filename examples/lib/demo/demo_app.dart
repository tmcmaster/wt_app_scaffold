import 'package:wt_app_scaffold/app_scaffolds.dart';

class DemoApp extends ConsumerWidget {
  static final log = logger(DemoApp);

  const DemoApp({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.read(FirebaseSetup.instance.login.notifier);
    final debugMode = ref.watch(ApplicationSettings.debugMode.value);

    // ref.read(wixAdminProviderManager);

    return AppContainer(
      appDefinition: AppDefinition.from(
        appTitle: 'Wix Admin',
        appName: 'wixApp',
        includeAppBar: true,
        menuAction: (context) => HiddenDrawerOpener.of(context)?.open(),
        debugMode: debugMode,
        logoutAction: ActionDefinition(
          icon: Icons.logout,
          title: 'Logout',
          onTap: (context) {
            auth.logout().then((value) {
              log.d('Routing to the login screen');
              Navigator.popUntil(context, (route) => route.settings.name == AppBuilder.routeName);
              Navigator.of(context).pushReplacementNamed(LoginView.routeName);
            });
          },
        ),
        profilePage: PageDefinition(
          title: 'Profile',
          icon: Icons.person,
          builder: (context) => const PlaceholderPage(title: 'Profile Page'),
        ),
        pages: [
          PageDefinition(
            title: 'Query Orders',
            icon: FontAwesomeIcons.clipboard,
            builder: (context) => const PlaceholderPage(title: 'Query Orders'),
          ),
          PageDefinition(
            title: 'Harvest List',
            icon: FontAwesomeIcons.tractor,
            builder: (context) => const PlaceholderPage(title: 'Harvest List'),
            debug: true,
          ),
          PageDefinition(
            title: 'Packing Sheets',
            icon: FontAwesomeIcons.boxesPacking,
            builder: (context) => PlaceholderPage(
              title: 'Packing Sheets',
              includeAppBar: false,
              menuAction: (context) => HiddenDrawerOpener.of(context)?.open(),
            ),
            debug: true,
          ),
          PageDefinition(
            title: 'Delivery Routes',
            icon: FontAwesomeIcons.car,
            builder: (context) => const PlaceholderPage(title: 'Delivery Routes'),
            debug: true,
          ),
          PageDefinition(
            title: 'Product Units',
            icon: FontAwesomeIcons.weightScale,
            builder: (context) => const PlaceholderPage(title: 'Product Units'),
            debug: true,
          ),
          PageDefinition(
            title: 'Settings',
            icon: Icons.settings,
            builder: (context) => const PlaceholderPage(title: 'Setting'),
            debug: false,
          ),
          PageDefinition(
            title: 'Testing',
            icon: FontAwesomeIcons.bug,
            builder: (context) => const PlaceholderPage(title: 'Testing'),
            debug: true,
          ),
          PageDefinition(
            title: 'User Log',
            icon: FontAwesomeIcons.bug,
            builder: (context) => const PlaceholderPage(title: 'User Log'),
            debug: true,
          ),
        ],
      ),
    );
  }
}
