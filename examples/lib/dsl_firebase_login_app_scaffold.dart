import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold_examples/apps/app_three.dart';
import 'package:wt_app_scaffold_examples/firebase_options.dart';
import 'package:wt_logging/wt_logging.dart';

void main() async {
  runMyApp(
    withFirebase(
      andLogin(
        andAppScaffold(
          appDetails: AppThree.details,
          appDefinition: AppThree.definition,
          appStyles: AppThree.styles,
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
    enableErrorMonitoring: true,
    enableProviderMonitoring: false,
    setApplicationLogLevel: Level.info,
  );
}
