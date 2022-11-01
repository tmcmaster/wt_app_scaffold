import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold_examples/apps/app_one.dart';
import 'package:wt_firepod/wt_firepod.dart';

import 'firebase_options.dart';

// TODO: need to add a page that gets data from the database.
void main() async {
  runMyApp(
    withFirebase(
      andAppScaffold(
          appDefinition: appOne,
          loginSupport: const LoginSupport(
            emailEnabled: true,
            googleEnabled: true,
          )),
      appName: 'wt-app-scaffold',
      firebaseOptions: DefaultFirebaseOptions.currentPlatform,
    ),
  );
}
