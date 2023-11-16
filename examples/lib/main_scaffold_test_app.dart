import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold_examples/apps/scaffold_test_app.dart';
import 'package:wt_logging/wt_logging.dart';

void main() {
  runMyApp(
    withAppScaffold(
      appDetails: ScaffoldTestApp.details,
      appDefinition: ScaffoldTestApp.definition,
      appStyles: ScaffoldTestApp.styles,
    ),
    includeObservers: [],
    includeOverrides: [],
    setApplicationLogLevel: Level.debug,
    enableProviderMonitoring: false,
  );
}
