import 'package:flutter/material.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/scaffolds/app/hidden_drawer_app/hidden_page_builder.dart';

import 'hidden_drawer_widget.dart';

class HiddenDrawerApp extends StatefulWidget {
  final AppDefinition appDefinition;
  final bool debugMode;

  const HiddenDrawerApp._({
    required this.appDefinition,
    this.debugMode = false,
  });

  factory HiddenDrawerApp.build(
    AppDefinition appDefinition,
    bool debugMode,
  ) {
    return HiddenDrawerApp._(
      appDefinition: appDefinition,
      debugMode: debugMode,
    );
  }

  @override
  _HiddenDrawerAppState createState() => _HiddenDrawerAppState();
}

class _HiddenDrawerAppState extends State<HiddenDrawerApp> {
  late double xOffset;
  late double yOffset;
  late double scaleFactor;
  late bool isDrawerOpen;

  PageDefinition? page;
  bool isDragging = false;

  @override
  void initState() {
    super.initState();

    closeDrawer();
  }

  void closeDrawer() {
    setState(() {
      xOffset = 0;
      yOffset = 0;
      scaleFactor = 1;
      isDrawerOpen = false;
    });
  }

  void openDrawer() {
    setState(() {
      xOffset = 230;
      yOffset = 150;
      scaleFactor = 0.6;
      isDrawerOpen = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.primary.withOpacity(0.3),
      body: Stack(
        children: [
          buildDrawer(context),
          buildPage(),
        ],
      ),
    );
  }

  Widget buildDrawer(BuildContext context) {
    return SafeArea(
      child: HiddenDrawerWidget(
        appDefinition: widget.appDefinition,
        debugMode: widget.debugMode,
        width: xOffset,
        onCloseDrawer: closeDrawer,
        onSelectedItem: (page) {
          setState(() => this.page = page);
          closeDrawer();
        },
      ),
    );
  }

  Widget buildPage() {
    return WillPopScope(
      onWillPop: () async {
        if (isDrawerOpen) {
          closeDrawer();
          return false;
        } else {
          return true;
        }
      },
      child: GestureDetector(
        onTap: closeDrawer,
        onHorizontalDragStart: (details) => isDragging = true,
        onHorizontalDragUpdate: (details) {
          if (!isDragging) return;
          const delta = 1;
          if (details.delta.dx > delta) {
            openDrawer();
          } else if (details.delta.dx < -delta) {
            closeDrawer();
          }
          isDragging = false;
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          transform: Matrix4.translationValues(xOffset, yOffset, 0)..scale(scaleFactor),
          child: AbsorbPointer(
            absorbing: isDrawerOpen,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(isDrawerOpen ? 20 : 0),
              child: Container(
                color: isDrawerOpen ? Colors.white12 : Theme.of(context).primaryColor,
                child: HiddenDrawerOpener(
                  open: openDrawer,
                  child: HiddenPageBuilder(
                    includeAppBar: widget.appDefinition.includeAppBar,
                    menuAction: widget.appDefinition.menuAction,
                    pageDefinition: page ?? widget.appDefinition.pages.first,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
