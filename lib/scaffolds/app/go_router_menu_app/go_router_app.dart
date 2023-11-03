import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/scaffolds/app/go_router_menu_app/bottom_menu_bar.dart';
import 'package:wt_app_scaffold/scaffolds/app/go_router_menu_app/cross_fade_transition_builder.dart';
import 'package:wt_logging/wt_logging.dart';

class GoRouterMenuApp extends ConsumerStatefulWidget {
  final AppDefinition appDefinition;
  final bool debugMode;

  const GoRouterMenuApp._({
    required this.appDefinition,
    required this.debugMode,
  });

  factory GoRouterMenuApp.build(
    AppDefinition appDefinition,
    bool debugMode,
  ) {
    return GoRouterMenuApp._(
      appDefinition: appDefinition,
      debugMode: debugMode,
    );
  }

  @override
  ConsumerState<GoRouterMenuApp> createState() => _GoRouterAppState();
}

class _GoRouterAppState extends ConsumerState<GoRouterMenuApp> {
  @override
  Widget build(BuildContext context) {
    final materialAppScaffoldKey = ref.read(UserLog.snackBarKey);
    return MaterialApp.router(
      title: 'Ecompod Example Application',
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: materialAppScaffoldKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: CrossFadeTransitionBuilder(),
            TargetPlatform.macOS: CrossFadeTransitionBuilder(),
          },
        ),
      ),
      routerConfig: _createRouterConfig(widget.appDefinition),
    );
  }

  GoRouter _createRouterConfig(AppDefinition appDefinition) {
    return GoRouter(
      initialLocation: BottomMenuBar.createRouteName(appDefinition.pages[1]),
      routes: appDefinition.pages
          .map(
            (page) => GoRoute(
              path: BottomMenuBar.createRouteName(page),
              builder: (context, _) => page.builder(context),
            ),
          )
          .toList(),
    );
  }
}
