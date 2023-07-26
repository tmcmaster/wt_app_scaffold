import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold_examples/apps/app_two.dart';
import 'package:wt_app_scaffold_examples/firebase_options.dart';
import 'package:wt_logging/wt_logging.dart';

void main() async {
  runMyApp(
    withFirebase(
      withLogin(
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
    includeObservers: [],
    includeOverrides: [],
    setApplicationLogLevel: Level.warning,
    enableProviderMonitoring: false,
  );
}
