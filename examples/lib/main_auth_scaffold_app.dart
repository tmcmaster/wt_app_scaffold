import 'package:wt_app_scaffold/app_platform/scaffold_app_dsl.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold_examples/apps/app_four.dart';

void main() {
  runMyApp(
    withAuthentication(
      andAppScaffold(
        applicationType: ApplicationType.hiddenDrawer,
        appStyles: AppFour.styles,
        appDetails: AppFour.details,
        appDefinition: AppFour.definition,
      ),
    ),
  );
}
