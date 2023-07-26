import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold_examples/apps/app_two.dart';

void main() async {
  runMyApp(
    withAppScaffold(
      appDetails: AppTwo.details,
      appDefinition: AppTwo.definition,
    ),
  );
}
