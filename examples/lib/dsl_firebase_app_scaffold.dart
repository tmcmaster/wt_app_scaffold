import 'package:wt_app_scaffold/app_platform/scaffold_app_dsl.dart';
import 'package:wt_app_scaffold_examples/apps/app_two.dart';
import 'package:wt_app_scaffold_examples/secrets/firebase_options.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_logging/wt_logging.dart';

void main() async {
  runMyApp(
    andFirebase(
      withAppScaffold(
        appDetails: AppTwo.details,
        appDefinition: AppTwo.definition,
        appStyles: AppTwo.styles,
      ),
      appName: 'wt-app-scaffold',
      firebaseOptions: DefaultFirebaseOptions.currentPlatform,
      database: true,
    ),
    enableProviderMonitoring: false,
    setApplicationLogLevel: Level.warning,
  );
}
