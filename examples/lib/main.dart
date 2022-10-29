import 'package:firepod/firebase_init.dart';
import 'package:sample_app/sample_app.dart';
import 'package:wt_app_scaffold/init/app_scaffold_init.dart';

import 'firebase_options.dart';

void main() async {
  runMyApp(
    withFirebase(
        andAppScaffold(
          () async => const SampleApp(),
          appDetailsProvider: SampleApp.appDetails,
        ),
        appName: 'wt-app-scaffold',
        firebaseOptions: DefaultFirebaseOptions.currentPlatform),
  );
}
