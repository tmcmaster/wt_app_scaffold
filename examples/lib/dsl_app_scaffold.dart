import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold_examples/apps/app_three.dart';

void main() async {
  runMyApp(
    withAppScaffold(
      appDetails: AppThree.details,
      appDefinition: AppThree.definition,
      appStyles: AppThree.styles,
    ),
  );
}
