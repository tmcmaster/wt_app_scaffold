import 'package:wt_app_scaffold/app_platform.dart';
import 'package:wt_app_scaffold_examples/apps/app_two.dart';
import 'package:wt_app_scaffold_examples/firebase_options.dart';
import 'package:wt_logging/wt_logging.dart';

void main() async {
  runMyApp(
    withFirebase(
      andAppScaffold(
        appDetails: AppTwo.details,
        appDefinition: AppTwo.definition,
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