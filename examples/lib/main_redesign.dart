import 'package:wt_app_scaffold/app_platform/scaffold_app_dsl.dart';
import 'package:wt_app_scaffold_examples/apps/app_two.dart';
import 'package:wt_app_scaffold_examples/firebase_options.dart';
import 'package:wt_firepod/wt_firepod.dart';

void main() {
  runMyApp(
    andFirebase(
      andFirebaseLogin(
        andAppScaffold(
          appStyles: AppTwo.styles,
          appDetails: AppTwo.details,
          appDefinition: AppTwo.definition,
        ),
        emailEnabled: true,
        googleEnabled: true,
      ),
      appName: 'wt-app-scaffold',
      firebaseOptions: DefaultFirebaseOptions.currentPlatform,
      database: true,
    ),
  );
}
