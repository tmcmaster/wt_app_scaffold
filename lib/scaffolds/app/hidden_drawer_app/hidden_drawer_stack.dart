import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/scaffolds/app/hidden_drawer_app/hidden_draw_controller.dart';
import 'package:wt_app_scaffold/scaffolds/app/hidden_drawer_app/hidden_drawer_config.dart';
import 'package:wt_app_scaffold/scaffolds/app/hidden_drawer_app/hidden_drawer_menu.dart';
import 'package:wt_app_scaffold/scaffolds/app/hidden_drawer_app/hidden_page_builder.dart';
import 'package:wt_logging/wt_logging.dart';

class HiddenDrawStack extends ConsumerStatefulWidget {
  final AppDefinition appDefinition;
  final bool debugMode;

  const HiddenDrawStack({
    required this.appDefinition,
    this.debugMode = false,
  });

  @override
  ConsumerState<HiddenDrawStack> createState() => _HiddenDrawStackState();
}

class _HiddenDrawStackState extends ConsumerState<HiddenDrawStack> {
  static final log = logger(HiddenDrawStack);
  late double xOffset;
  late double yOffset;
  late double scaleFactor;
  late bool isDrawerOpen;

  PageDefinition? page;
  bool isDragging = false;
  late final double offsetWhenOpenX;
  late final double offsetWhenOpenY;

  @override
  void initState() {
    super.initState();

    final maxLength = widget.appDefinition.pages
        .map((p) => p.title.split(' '))
        .expand((e) => e)
        .map((e) => e.length)
        .fold(0, (largest, size) => size > largest ? size : largest);

    offsetWhenOpenX = 140.0 + HiddenDrawerConfig.menuFontSize * 0.55 * maxLength;
    offsetWhenOpenY = 150.0;

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
    log.d('Opening draw');
    setState(() {
      xOffset = offsetWhenOpenX;
      yOffset = offsetWhenOpenY;
      scaleFactor = 0.6;
      isDrawerOpen = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final newPage = ref.watch(HiddenDrawPageController.page);
    return Scaffold(
      backgroundColor: HSLColor.fromColor(colorScheme.primary).withLightness(0.1).toColor(),
      body: Stack(
        children: [
          buildHiddenDrawMenu(context),
          buildHiddenDrawerPage(newPage),
          // buildPage(page ?? widget.appDefinition.pages.first),
        ],
      ),
    );
  }

  Widget buildHiddenDrawMenu(BuildContext context) {
    return SafeArea(
      child: HiddenDrawerMenu(
        appDefinition: widget.appDefinition,
        debugMode: widget.debugMode,
        width: xOffset,
        onCloseDrawer: closeDrawer,
        onSelectedItem: (page) {
          ref.read(HiddenDrawPageController.router).go(page.route);
          // setState(() => this.page = page);
          closeDrawer();
        },
      ),
    );
  }

  Widget buildHiddenDrawerPage(PageDefinition page) {
    return PopScope(
      canPop: isDrawerOpen,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          closeDrawer();
        }
      },
      child: GestureDetector(
        onTap: isDrawerOpen ? closeDrawer : null,
        onHorizontalDragStart: widget.appDefinition.swipeEnabled ? (details) => isDragging = true : null,
        onHorizontalDragUpdate: widget.appDefinition.swipeEnabled
            ? (details) {
                if (!isDragging) return;
                const delta = 1;
                if (details.delta.dx > delta) {
                  openDrawer();
                } else if (details.delta.dx < -delta) {
                  closeDrawer();
                }
                isDragging = false;
              }
            : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          transform: Matrix4.translationValues(xOffset, yOffset, 0)..scale(scaleFactor),
          child: AbsorbPointer(
            absorbing: isDrawerOpen,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(isDrawerOpen ? 20 : 0),
              child: ColoredBox(
                color: isDrawerOpen ? Colors.white12 : Theme.of(context).primaryColor,
                child: HiddenDrawerOpener(
                  open: openDrawer,
                  child: HiddenPageBuilder(
                    includeAppBar: widget.appDefinition.includeAppBar,
                    menuAction: widget.appDefinition.menuAction,
                    pageType: widget.appDefinition.scaffoldPageType,
                    pageDefinition: page,
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
