import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold_examples/apps/app_two.dart';
import 'package:wt_app_scaffold_examples/firebase_options.dart';
import 'package:wt_logging/wt_logging.dart';

void main() async {
  runMyApp(
    withFirebase(
      andLogin(
        andAppScaffold(
          appDetails: AppTwo.details,
          appDefinition: AppTwo.definition,
        ),
        loginSupport: const LoginSupport(
          emailEnabled: true,
          googleEnabled: true,
        ),
      ),
      appName: 'wt-app-scaffold',
      firebaseOptions: DefaultFirebaseOptions.currentPlatform,
    ),
    virtualSize: 1200,
    includeObservers: [],
    includeOverrides: [],
    enableErrorMonitoring: true,
    enableProviderMonitoring: false,
    setApplicationLogLevel: Level.info,
  );
}
