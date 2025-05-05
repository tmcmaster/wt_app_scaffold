import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wt_app_scaffold/app_platform/util/app_scaffold_router.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/models/app_spacing.dart';
import 'package:wt_app_scaffold/scaffolds/page/common/app_scaffold_page.dart';
import 'package:wt_app_scaffold/scaffolds/page/page_definition_scaffold/bottom_menu_bar.dart';
import 'package:wt_app_scaffold/scaffolds/page/page_definition_scaffold/irregular_header_painter.dart';
import 'package:wt_app_scaffold/scaffolds/page/page_definition_scaffold/tab_menu.dart';
import 'package:wt_app_scaffold/scaffolds/page/page_definition_scaffold/transparent_card.dart';
import 'package:wt_logging/wt_logging.dart';

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
  static final log = logger(PageDefinitionScaffold, level: Level.debug);

  late TabController controller;
  // int selected = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    controller = TabController(
      length: widget.pageDefinition.childPages.length + 1,
      vsync: this,
      initialIndex: _calculateInitialTabIndex(widget.pageDefinition, widget.state),
    );
  }

  static int _calculateInitialTabIndex(PageDefinition pageDefinition, GoRouterState? state) {
    if (state != null && state.extra != null && state.extra is int) {
      final int initialTabIndex = state.extra! as int;
      if (initialTabIndex < pageDefinition.childPages.length) {
        return initialTabIndex;
      } else {
        log.w('The state is requesting tab index $initialTabIndex '
            'but there are only ${pageDefinition.childPages.length} tabs.');
      }
    }
    return 0;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tabIndex = Uri.parse(GoRouterState.of(context).uri.toString()).queryParameters['tabIndex'];
    if (tabIndex != null) {
      controller.animateTo(int.parse(tabIndex));
    }
    final pages = [
      widget.pageDefinition,
      ...widget.pageDefinition.childPages,
    ];

    const topMargin = 0.0;
    final hasTabs = pages.length > 1;
    final tabsHeight = hasTabs ? 42.0 : 0.0;
    final bottomBarHeight = widget.pageDefinition.showBottomMenu ? 50 : 0.0;

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
                title: Text(widget.pageDefinition.pageInfo.title),
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
                actions: widget.pageDefinition.homeRoute == null
                    ? null
                    : [
                        Padding(
                          padding: const EdgeInsets.only(right: 30.0),
                          child: IconButton(
                            onPressed: () {
                              ref.read(AppScaffoldRouter.provider).go('/${widget.pageDefinition.homeRoute!}');
                            },
                            icon: const Icon(Icons.chevron_left),
                          ),
                        ),
                      ],
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
              if (pages.length > 1)
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
                                titles: pages.map((p) => p.pageInfo.tabTitle).toList(),
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
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: TabBarView(
                                    physics: const NeverScrollableScrollPhysics(),
                                    controller: controller,
                                    children: pages
                                        .map(
                                          (page) => AppScaffoldPage(pageDefinition: page),
                                        )
                                        .toList(),
                                  ),
                                )
                              : AppScaffoldPage(pageDefinition: pages.first),
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
                  onChange: (routeName, context, ref) {
                    ref.read(AppScaffoldRouter.provider).go(routeName);
                  },
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
