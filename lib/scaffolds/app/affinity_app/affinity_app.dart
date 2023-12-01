import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_platform/auth/app_scaffold_authentication.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_logging/wt_logging.dart';

class AffinityApp extends ConsumerWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static final snackBarKey = GlobalKey<ScaffoldMessengerState>();

  final AppDefinition appDefinition;
  final bool debugMode;

  const AffinityApp._({
    required this.appDefinition,
    required this.debugMode,
  });

  factory AffinityApp.build(
    AppDefinition appDefinition,
    bool debugMode,
  ) {
    return AffinityApp._(
      appDefinition: appDefinition,
      debugMode: debugMode,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snackBarKey = ref.read(UserLog.snackBarKey);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return MaterialApp(
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: snackBarKey,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'My App',
                style: textTheme.displayLarge!.copyWith(
                  color: colorScheme.primary,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        ref
                            .read(AppScaffoldAuthenticationStore.user.notifier)
                            .signOut();
                      },
                      child: const Text('Sign Out'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        ref
                            .read(AppScaffoldAuthenticationStore.user.notifier)
                            .signInWithEmail('', '');
                      },
                      child: const Text('Sign In'),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      ref.read(UserLog.provider).log(
                            'Testing SnackBar',
                            showSnackBar: true,
                          );
                    },
                    child: const Text('SnackBar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(UserLog.provider).log(
                            'Testing Dialog',
                            showDialog: true,
                          );
                    },
                    child: const Text('Dialog'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
