# wt_app_scaffold

An extension to the idea of scaffolds, making it easier to start a new project and just
focus on the functionality.

## Example of defining application details

```dart
final appDetailsProvider = Provider(
  name: 'App Details',
  (ref) => AppDetails(
    title: 'Wix Admin',
    subTitle: '',
    iconPath: 'assets/avocado.png',
  ),
);
```

## Example of defining the application.

```dart
final appDefinitionProvider = Provider<AppDefinition>((ref) {
  final debugMode = ref.watch(ApplicationSettings.debugMode.value);

  return AppDefinition.from(
    appTitle: 'Wix Admin',
    appName: 'wixApp',
    appDetailsProvider: appDetailsProvider,
    includeAppBar: true,
    menuAction: (context) => HiddenDrawerOpener.of(context)?.open(),
    debugMode: debugMode,
    profilePage: PageDefinition(
      title: 'Profile',
      icon: Icons.person,
      builder: (context) => const PlaceholderPage(title: 'Profile Page'),
    ),
    logoutAction: LogoutAction(ref),
    pages: [
      PageDefinition(
        title: 'Query Orders',
        icon: FontAwesomeIcons.clipboard,
        builder: (context) => const OrderQueryView(),
        primary: true,
      ),
      PageDefinition(
        title: 'Harvest List',
        icon: FontAwesomeIcons.tractor,
        builder: (context) => PlaceholderPage(
          title: 'Harvest List',
          includeAppBar: false,
          menuAction: (context) => HiddenDrawerOpener.of(context)?.open(),
        ),
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
        title: 'Packing Stickers',
        icon: FontAwesomeIcons.noteSticky,
        builder: (context) => const StickersView(),
        primary: true,
      ),
      PageDefinition(
        title: 'Delivery Routes',
        icon: FontAwesomeIcons.car,
        builder: (context) => const DeliveryView(),
        primary: true,
      ),
      PageDefinition(
        title: 'Product Info',
        icon: FontAwesomeIcons.weightScale,
        builder: (_) => const ProductInfoView(),
        primary: true,
      ),
      PageDefinition(
        title: 'Settings',
        icon: Icons.settings,
        builder: (context) => const SettingsView(),
        primary: true,
      ),
      PageDefinition(
        title: 'User Log',
        icon: FontAwesomeIcons.bug,
        builder: (context) => const UserLogView(),
      ),
    ],
    localizationDelegates: [
      //AppLocalizations.delegate,
      FormBuilderLocalizations.delegate,
    ],
  );
});

```

## Example of running the application.

```dart
import 'package:wix_admin/firebase_options.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_firepod/wt_firepod.dart';

import 'app/wix_admin.dart';

void main() async {
  runMyApp(
    withFirebase(
      andAppScaffold(
          appDetails: appDetailsProvider,
          appDefinition: appDefinitionProvider,
          loginSupport: const LoginSupport(
            googleEnabled: true,
            emailEnabled: true,
          )),
      appName: 'wix-admin',
      firebaseOptions: DefaultFirebaseOptions.currentPlatform,
    ),
  );
}
```

## Screenshot of an example app

This is a screenshot of the menu screen, where the current page slides to the side
and becomes smaller, to reveal the menu that is below it.

<p align="center">
    <img src="examples/screenshots/wix-app-screenshot.png"  width="400">
</p>