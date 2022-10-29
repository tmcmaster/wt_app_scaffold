import 'package:firepod/firebase_init.dart';
import 'package:sample_app/demo_app.dart';
import 'package:wt_app_scaffold/init/app_scaffold_init.dart';

import 'firebase_options.dart';

void main() async {
  runMyApp(
    withFirebase(
      andAppScaffold(
        const DemoApp(),
        appDetailsProvider: DemoApp.appDetails,
      ),
      appName: 'wt-app-scaffold',
      firebaseOptions: DefaultFirebaseOptions.currentPlatform,
    ),
  );
}
