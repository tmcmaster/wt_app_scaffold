import 'package:wt_app_scaffold/app_platform/scaffold_app_dsl.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold_examples/apps/app_four.dart';
import 'package:wt_app_scaffold_examples/firebase_options.dart';
import 'package:wt_firepod/wt_firepod.dart';

void main() {
  runMyApp(
    withAuthentication(
      andFirebase(
        // andFirebaseLogin(
        andAppScaffold(
          applicationType: ApplicationType.hiddenDrawer,
          appStyles: AppFour.styles,
          appDetails: AppFour.details,
          appDefinition: AppFour.definition,
        ),
        //   emailEnabled: true,
        //   googleEnabled: true,
        // ),
        appName: 'wt-app-scaffold',
        firebaseOptions: DefaultFirebaseOptions.currentPlatform,
      ),
    ),
  );
}
