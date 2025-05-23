import 'package:wt_app_scaffold/app_platform/scaffold_app_dsl.dart';
import 'package:wt_app_scaffold_examples/apps/app_three.dart';

void main() {
  runMyApp(
    withAppScaffold(
      appDetails: AppThree.details,
      appDefinition: AppThree.definition,
      appStyles: AppThree.styles,
    ),
  );
}
