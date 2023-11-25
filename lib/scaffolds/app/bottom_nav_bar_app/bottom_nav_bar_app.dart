import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/scaffolds/app/bottom_nav_bar_app/bottom_nav_bar_menu.dart';
import 'package:wt_app_scaffold/scaffolds/app/bottom_nav_bar_app/bottom_nav_bar_page_view.dart';
import 'package:wt_app_scaffold/scaffolds/app/bottom_nav_bar_app/bottom_nav_bar_selected_page_notifier.dart';
import 'package:wt_app_scaffold/scaffolds/app/bottom_nav_bar_app/page_change_event.dart';

class BottomNavBarApp extends StatefulWidget {
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
  State<BottomNavBarApp> createState() => _BottomNavBarAppState();
}

class _BottomNavBarAppState extends State<BottomNavBarApp> {
  late StateNotifierProvider<BottomNavBarSelectedPageNotifier, PageChangeEvent>
      _selectedPageProvider;

  @override
  void initState() {
    final initialIndex = widget.appDefinition.pages
        .indexOf(widget.appDefinition.pages.firstWhere((page) => page.primary));

    _selectedPageProvider = StateNotifierProvider<
        BottomNavBarSelectedPageNotifier, PageChangeEvent>(
      (ref) => BottomNavBarSelectedPageNotifier(initialIndex),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.appDefinition.pages.where((page) {
      return widget.debugMode || !page.debug;
    }).toList();

    return Scaffold(
      body: BottomNavBarPageView(
        items: items,
        debugMode: widget.debugMode,
        swipeEnabled: widget.appDefinition.swipeEnabled,
        provider: _selectedPageProvider,
      ),
      bottomNavigationBar: BottomNavBarMenu(
        items: items,
        provider: _selectedPageProvider,
      ),
    );
  }
}
