import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_platform/widget/app_scaffold_material_app.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/providers/app_scaffolds_providers.dart';
import 'package:wt_app_scaffold/scaffolds/app/bottom_nav_bar_app/bottom_nav_bar_menu.dart';
import 'package:wt_app_scaffold/scaffolds/app/bottom_nav_bar_app/bottom_nav_bar_page_view.dart';
import 'package:wt_app_scaffold/scaffolds/app/bottom_nav_bar_app/bottom_nav_bar_selected_page_notifier.dart';
import 'package:wt_app_scaffold/scaffolds/app/bottom_nav_bar_app/page_change_event.dart';
import 'package:wt_logging/wt_logging.dart';

class BottomNavBarApp extends ConsumerStatefulWidget {
  static final pageChangeEvent =
      StateNotifierProvider<BottomNavBarSelectedPageNotifier, PageChangeEvent>(
    name: 'BottomNavBarApp.pageChangeEvent',
    (ref) {
      final pages = ref.watch(AppScaffoldProviders.appPages);
      final initialPageIndex = ref.watch(
        AppScaffoldProviders.appInitialPageIndex,
      );
      return BottomNavBarSelectedPageNotifier(
        pages: pages,
        initialPage: initialPageIndex,
      );
    },
  );

  static final router = pageChangeEvent.notifier;

  static final navigatorKey = GlobalKey<NavigatorState>();

  final AppDefinition appDefinition;
  final bool debugMode;

  const BottomNavBarApp._({
    required this.appDefinition,
    required this.debugMode,
  });

  factory BottomNavBarApp.build(
    AppDefinition appDefinition,
    bool debugMode,
  ) {
    return BottomNavBarApp._(
      appDefinition: appDefinition,
      debugMode: debugMode,
    );
  }

  @override
  ConsumerState<BottomNavBarApp> createState() => _BottomNavBarAppState();
}

class _BottomNavBarAppState extends ConsumerState<BottomNavBarApp> {
  static final log = logger(BottomNavBarApp, level: Level.debug);
  @override
  Widget build(BuildContext context) {
    log.d('Rebuilding');
    return AppScaffoldMaterialApp.fromWidget(
      Scaffold(
        body: BottomNavBarPageView(
          debugMode: widget.debugMode,
          swipeEnabled: widget.appDefinition.swipeEnabled,
          provider: BottomNavBarApp.pageChangeEvent,
        ),
        bottomNavigationBar: BottomNavBarMenu(
          provider: BottomNavBarApp.pageChangeEvent,
        ),
      ),
    );
  }
}
