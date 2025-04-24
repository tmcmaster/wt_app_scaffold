import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/models/app_scaffold_page_context.dart';
import 'package:wt_app_scaffold/models/app_spacing.dart';
import 'package:wt_app_scaffold/scaffolds/page/page_definition_scaffold/bottom_menu_bar.dart';
import 'package:wt_app_scaffold/scaffolds/page/page_definition_scaffold/irregular_header_painter.dart';
import 'package:wt_app_scaffold/scaffolds/page/page_definition_scaffold/tab_menu.dart';
import 'package:wt_app_scaffold/scaffolds/page/page_definition_scaffold/transparent_card.dart';

class PageDefinitionScaffold extends ConsumerStatefulWidget {
  final PageDefinition pageDefinition;
  final GoRouterState? state;
  final double maxCardWidth;
  const PageDefinitionScaffold({
    required this.pageDefinition,
    this.state,
    this.maxCardWidth = 1200,
  });

  @override
  ConsumerState<PageDefinitionScaffold> createState() => _PageDefinitionScaffoldState();
}

class _PageDefinitionScaffoldState extends ConsumerState<PageDefinitionScaffold> with TickerProviderStateMixin {
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
    final bottomBarHeight = widget.pageDefinition.showBottomMenu ? 50 : 0;

    final colorScheme = Theme.of(context).colorScheme;
    final primaryColor = colorScheme.primary;
    final onPrimaryColor = colorScheme.onPrimary;

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: widget.pageDefinition.showAppBar
            ? AppBar(
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
                          iconColor: WidgetStateProperty.all(onPrimaryColor),
                        ),
                        onPressed: () {
                          _scaffoldKey.currentState!.openDrawer();
                        },
                      ),
              )
            : null,
        body: LayoutBuilder(builder: (context, constraints) {
          final spacing = AppSpacing.of(context);
          final width = constraints.maxWidth;
          final height = constraints.maxHeight;
          final aspect = width / height;
          final maxWidth = widget.maxCardWidth;

          const cardTop = topMargin;
          final cardHeight = height - topMargin - tabsHeight - spacing.large - bottomBarHeight;

          final cardLeft = width < maxWidth * 1.05 ? width * 0.05 : (width - maxWidth) / 2;
          final cardWidth = width < maxWidth * 1.05 ? width * 0.9 : maxWidth;

          return Column(
            children: [
              if (pages.length > 2)
                ColoredBox(
                  color: primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: cardWidth,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(bottom: 8),
                              color: Colors.transparent,
                              width: cardWidth,
                              child: TabMenu(
                                titles: pages.map((p) => p.tabTitle).toList(),
                                controller: controller,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              Expanded(
                child: Stack(
                  clipBehavior: Clip.hardEdge,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: AspectRatio(
                        aspectRatio: _constrainAspectRation(aspect) * 3,
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
                          child: pages.length > 1
                              ? TabBarView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  controller: controller,
                                  children: pages
                                      .map(
                                        (page) => page.builder(
                                          AppScaffoldPageContext(
                                            context: context,
                                            ref: ref,
                                            page: page,
                                            state: widget.state,
                                          ),
                                        ),
                                      )
                                      .toList(),
                                )
                              : pages.first.builder(
                                  AppScaffoldPageContext(
                                    context: context,
                                    ref: ref,
                                    page: pages.first,
                                    state: widget.state,
                                  ),
                                ),
                        ),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.pageDefinition.showBottomMenu)
                BottomMenuBar(
                  activeRoute: widget.pageDefinition.route,
                ),
            ],
          );
        }),
        drawer: widget.pageDefinition.drawerBuilder == null
            ? null
            : Drawer(
                backgroundColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                shadowColor: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: onPrimaryColor.withValues(alpha: 0.7),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: widget.pageDefinition.drawerBuilder?.call(context),
                ),
              ),
      ),
    );
  }

  double _constrainAspectRation(
    double aspect, {
    double min = 0.25,
    double max = 2.5,
  }) {
    return (aspect < min
        ? min
        : aspect > max
            ? max
            : aspect);
  }
}
