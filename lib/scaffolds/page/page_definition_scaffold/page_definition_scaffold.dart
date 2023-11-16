import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/scaffolds/app/go_router_menu_app/bottom_menu_bar.dart';
import 'package:wt_app_scaffold/scaffolds/page/page_definition_scaffold/irregular_header_painter.dart';
import 'package:wt_app_scaffold/scaffolds/page/page_definition_scaffold/tab_menu.dart';
import 'package:wt_app_scaffold/scaffolds/page/page_definition_scaffold/transparent_card.dart';

class PageDefinitionScaffold extends StatefulWidget {
  final PageDefinition pageDefinition;
  final GoRouterState? state;
  const PageDefinitionScaffold({
    required this.pageDefinition,
    this.state,
  });

  @override
  State<PageDefinitionScaffold> createState() => _PageDefinitionScaffoldState();
}

class _PageDefinitionScaffoldState extends State<PageDefinitionScaffold>
    with TickerProviderStateMixin {
  static const maxWidth = 800.0;

  late TabController controller;
  int selected = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    controller = TabController(
      length: widget.pageDefinition.childPages.length + 1,
      vsync: this,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      widget.pageDefinition,
      ...widget.pageDefinition.childPages,
    ];

    const topMargin = 0.0;
    final hasTabs = pages.length > 1;
    final tabsHeight = hasTabs ? 42.0 : 0.0;

    final colorScheme = Theme.of(context).colorScheme;
    final primaryColor = colorScheme.primary;
    final onPrimaryColor = colorScheme.onPrimary;

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        final aspect = width / height;

        const cardTop = topMargin;
        final cardHeight = height - topMargin - tabsHeight - 130;

        final cardLeft =
            width < maxWidth * 1.05 ? width * 0.05 : (width - maxWidth) / 2;
        final cardWidth = width < maxWidth * 1.05 ? width * 0.9 : maxWidth;

        return SafeArea(
          child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              centerTitle: widget.pageDefinition.centerTitle,
              backgroundColor: primaryColor,
              foregroundColor: onPrimaryColor,
              titleTextStyle: TextStyle(
                color: onPrimaryColor,
                fontSize: 20,
              ),
              elevation: 0,
              title: Text(widget.pageDefinition.title),
              leading: widget.pageDefinition.drawerBuilder == null
                  ? null
                  : DrawerButton(
                      style: ButtonStyle(
                        iconColor: MaterialStateProperty.all(onPrimaryColor),
                      ),
                      onPressed: () {
                        _scaffoldKey.currentState!.openDrawer();
                      },
                    ),
            ),
            drawer: widget.pageDefinition.drawerBuilder == null
                ? null
                : Drawer(
                    backgroundColor: Colors.transparent,
                    surfaceTintColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    width: width * 0.7,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: onPrimaryColor.withOpacity(0.7),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: widget.pageDefinition.drawerBuilder?.call(context),
                    ),
                  ),
            body: Column(
              children: [
                if (pages.length > 2)
                  ColoredBox(
                    color: primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: TabMenu(
                        titles: pages.map((p) => p.title).toList(),
                        controller: controller,
                      ),
                    ),
                  ),
                Expanded(
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: AspectRatio(
                          aspectRatio: aspect * 3,
                          child: SizedBox(
                            width: double.infinity,
                            child: CustomPaint(
                              painter: IrregularHeaderPainter(
                                color: primaryColor,
                              ),
                              child: Container(),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: cardTop,
                        left: cardLeft,
                        width: cardWidth,
                        height: cardHeight,
                        child: Scaffold(
                          body: TransparentCard(
                            child: TabBarView(
                              physics: const NeverScrollableScrollPhysics(),
                              controller: controller,
                              children: pages
                                  .map(
                                    (page) => page.builder(
                                      context,
                                      page,
                                      widget.state,
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            bottomNavigationBar: BottomMenuBar(
              activeRoute: BottomMenuBar.createRouteName(widget.pageDefinition),
            ),
          ),
        );
      },
    );
  }
}
