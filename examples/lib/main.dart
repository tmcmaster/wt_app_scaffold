import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold_examples/apps/app_one.dart';
import 'package:wt_firepod/wt_firepod.dart';

import 'firebase_options.dart';

void main() async {
  runMyApp(
    withFirebase(
      appName: 'wt-app-scaffold',
      firebaseOptions: DefaultFirebaseOptions.currentPlatform,
      andAppScaffold(
        appDetails: AppOne.details,
        appDefinition: AppOne.definition,
        loginSupport: const LoginSupport(
          emailEnabled: true,
          googleEnabled: true,
        ),
      ),
    ),
  );
}
