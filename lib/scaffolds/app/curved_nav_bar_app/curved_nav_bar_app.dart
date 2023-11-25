import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/providers/app_scaffolds_providers.dart';
import 'package:wt_app_scaffold/scaffolds/app/curved_nav_bar_app/curved_nav_bar.dart';
import 'package:wt_app_scaffold/scaffolds/app/curved_nav_bar_app/curved_nav_bar_controller.dart';
import 'package:wt_app_scaffold/scaffolds/app/curved_nav_bar_app/curved_nav_bar_page.dart';
import 'package:wt_logging/wt_logging.dart';

class CurvedNavBarApp extends ConsumerStatefulWidget {
  static final log = logger(CurvedNavBarApp);

  static final controller = StateNotifierProvider<CurvedNavBarController,
      GlobalKey<CurvedNavigationBarState>>(
    (ref) => CurvedNavBarController(
      ref,
      appDefinition: ref.read(
        AppScaffoldProviders.appDefinition,
      ),
    ),
  );

  final AppDefinition appDefinition;
  final bool debugMode;
  CurvedNavBarApp._({
    required this.appDefinition,
    required this.debugMode,
  }) {
    log.d(
      'CurvedNavBarApp() : CurvedNavBarApp constructor',
    );
  }

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
  static final log = logger(CurvedNavBarApp);

  int index = 0;
  String? route;

  @override
  void initState() {
    route = ref
        .read(CurvedNavBarApp.controller.notifier)
        .getPageByIndex(index)
        ?.route;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log.d('_CurvedNavBarAppState: rebuilding the Curved Nav Bar app');
    final controller = ref.read(CurvedNavBarApp.controller.notifier);

    if (route != null) {
      final expectedRoute = controller.getPageByIndex(index)?.route;
      if (expectedRoute != route) {
        final newIndex = controller.getIndexByRoute(route!);
        if (newIndex != null) {
          setState(() {
            index = newIndex;
          });
        }
      }
    }

    final navigationKey = ref.read(CurvedNavBarApp.controller);

    return SafeArea(
      top: false,
      child: ClipRect(
        child: Scaffold(
          extendBody: true,
          backgroundColor: Colors.transparent,
          body: CurvedNavBarPage(
            index: index,
          ),
          bottomNavigationBar: CurvedNavBar(
            navigationKey: navigationKey,
            index: index,
            onChange: (newIndex) {
              setState(() {
                index = newIndex;
                route = controller.getPageByIndex(newIndex)?.route;
              });
            },
          ),
        ),
      ),
    );
  }
}
