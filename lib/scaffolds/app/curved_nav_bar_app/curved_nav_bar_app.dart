import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_platform/widget/app_scaffold_material_app.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/providers/app_scaffolds_providers.dart';
import 'package:wt_app_scaffold/scaffolds/app/curved_nav_bar_app/curved_nav_bar_controller.dart';
import 'package:wt_app_scaffold/scaffolds/app/curved_nav_bar_app/curved_nav_bar_screen.dart';
import 'package:wt_logging/wt_logging.dart';

class CurvedNavBarApp extends ConsumerStatefulWidget {
  static final log = logger(CurvedNavBarApp);

  static final controller = StateNotifierProvider<CurvedNavBarController,
      GlobalKey<CurvedNavigationBarState>>(
    (ref) {
      ref.watch(AppScaffoldProviders.appSecondaryPages);
      return CurvedNavBarController(ref);
    },
  );

  static final router = controller.notifier;

  final AppDefinition appDefinition;
  final bool debugMode;
  const CurvedNavBarApp._({
    required this.appDefinition,
    required this.debugMode,
  });

  factory CurvedNavBarApp.build(
    AppDefinition appDefinition,
    bool debugMode,
  ) {
    log.d('CurvedNavBarApp.build - REBUILDING CurvedNavBarApp');
    return CurvedNavBarApp._(
      appDefinition: appDefinition,
      debugMode: debugMode,
    );
  }
  @override
  ConsumerState<CurvedNavBarApp> createState() => _CurvedNavBarAppState();
}

class _CurvedNavBarAppState extends ConsumerState<CurvedNavBarApp> {
  static final log = logger(CurvedNavBarApp, level: Level.debug);

  @override
  Widget build(BuildContext context) {
    log.d('_CurvedNavBarAppState: rebuilding the Curved Nav Bar app');

    return AppScaffoldMaterialApp.fromWidget(
      const SafeArea(
        top: false,
        child: ClipRect(
          child: CurveNavBarScreen(),
        ),
      ),
    );
  }
}
