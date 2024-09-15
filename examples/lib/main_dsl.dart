import 'package:wt_app_scaffold/app_platform/scaffold_app_dsl.dart';
import 'package:wt_app_scaffold_examples/apps/app_one.dart';
import 'package:wt_app_scaffold_examples/secrets/firebase_options.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_logging/wt_logging.dart';

void main() async {
  runMyApp(
    withFirebase(
      andFirebaseLogin(
        andAppScaffold(
          appDetails: AppOne.details,
          appDefinition: AppOne.definition,
          appStyles: AppOne.styles,
        ),
        emailEnabled: true,
        googleEnabled: true,
      ),
      appName: 'wt-app-scaffold',
      firebaseOptions: DefaultFirebaseOptions.currentPlatform,
    ),
    // virtualSize: 1200,
    includeObservers: [],
    includeOverrides: [],
    enableProviderMonitoring: false,
    setApplicationLogLevel: Level.warning,
  );
}
