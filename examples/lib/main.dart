import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold_examples/apps/chat_gpt/first_app/first_app.dart';
import 'package:wt_app_scaffold_examples/firebase_options.dart';
import 'package:wt_firepod/wt_firepod.dart';

void main() async {
  runMyApp(
    withFirebase(
      appName: 'wt-app-scaffold',
      firebaseOptions: DefaultFirebaseOptions.currentPlatform,
      andAppScaffold(
        appDetails: FirstApp.details,
        appDefinition: FirstApp.definition,
        loginSupport: const LoginSupport(
          emailEnabled: true,
          googleEnabled: true,
        ),
      ),
    ),
  );
}
