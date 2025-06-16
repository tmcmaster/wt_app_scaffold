import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wt_app_definition/app_definition.dart';
import 'package:wt_app_scaffold/providers/app_scaffold_store.dart';
import 'package:wt_app_scaffold/scaffolds/page/common/app_scaffold_page/app_scaffold_page.dart';
import 'package:wt_app_scaffold/scaffolds/page/page_definition_scaffold/bottom_menu_bar.dart';
import 'package:wt_app_scaffold/scaffolds/page/page_definition_scaffold/decorated_container/decorated_container.dart';
import 'package:wt_app_scaffold/scaffolds/page/page_definition_scaffold/decorated_container/irregular_header_painter.dart';
import 'package:wt_app_scaffold/widgets/app_scaffold_tab_panel.dart';
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
  static final log = logger(PageDefinitionScaffold);

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
    if (widget.state != null) {
      final uri = Uri.parse(GoRouterState.of(context).uri.toString());
      if (uri.queryParameters.containsKey('tabIndex')) {
        final tabIndex = uri.queryParameters['tabIndex'];
        if (tabIndex != null) {
          controller.animateTo(int.parse(tabIndex));
        }
      }
    }

    final pages = [
      widget.pageDefinition,
      ...widget.pageDefinition.childPages,
    ].where((page) => !page.isHidden).toList();

    final spacing = AppSpacing.of(context);

    final topMargin = spacing.large;
    final bottomMargin = spacing.medium;

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
                title: Text(widget.pageDefinition.info.title),
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
                actions: widget.pageDefinition.hideBackButton || widget.pageDefinition.homeRoute == null
                    ? null
                    : [
                        Padding(
                          padding: const EdgeInsets.only(right: 30.0),
                          child: IconButton(
                            onPressed: () {
                              ref.read(AppScaffoldStore.router).go(widget.pageDefinition.homeRoute!.route);
                            },
                            icon: const Icon(Icons.chevron_left),
                          ),
                        ),
                      ],
              )
            : null,
        body: Column(
          children: [
            Expanded(
              child: DecoratedContainer(
                painter: IrregularHeaderPainter(
                  color: primaryColor,
                ),
                padding: EdgeInsets.only(
                  top: topMargin,
                  bottom: bottomMargin,
                  left: spacing.medium,
                  right: spacing.medium,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: pages.length > 1
                      ? AppScaffoldTabPanel(
                          pageDefinitions: pages,
                          state: widget.state,
                        )
                      : AppScaffoldPage(
                          pageDefinition: pages.first,
                          state: widget.state,
                        ),
                ),
              ),
            ),
            if (widget.pageDefinition.showBottomMenu)
              BottomMenuBar(
                activeRoute: widget.pageDefinition.info.route,
                onChange: (routeName, context, ref) {
                  ref.read(AppScaffoldStore.router).go(routeName);
                },
              ),
          ],
        ),
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
}
