import 'package:wt_app_scaffold/app_platform.dart';
import 'package:wt_app_scaffold_examples/apps/app_one.dart';
import 'package:wt_app_scaffold_examples/firebase_options.dart';
import 'package:wt_logging/wt_logging.dart';

void main() async {
  runMyApp(
    withFirebase(
      andLogin(
        andAppScaffold(
          appDetails: AppOne.details,
          appDefinition: AppOne.definition,
        ),
        loginSupport: const LoginSupport(
          emailEnabled: true,
          googleEnabled: true,
        ),
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
