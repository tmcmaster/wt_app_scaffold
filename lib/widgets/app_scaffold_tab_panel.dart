import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wt_app_definition/app_definition.dart';
import 'package:wt_app_scaffold/scaffolds/app/go_router_menu_app/route_state_store.dart';
import 'package:wt_app_scaffold/scaffolds/page/common/app_scaffold_page/app_scaffold_page.dart';
import 'package:wt_app_scaffold/widgets/app_scaffold_tab_panel_tabs.dart';
import 'package:wt_logging/wt_logging.dart';

class AppScaffoldTabPanel extends ConsumerStatefulWidget {
  final List<PageDefinition> pageDefinitions;
  final GoRouterState? state;
  final double maxCardWidth;
  const AppScaffoldTabPanel({
    super.key,
    required this.pageDefinitions,
    this.state,
    this.maxCardWidth = 1200,
  });

  @override
  ConsumerState<AppScaffoldTabPanel> createState() => _PageDefinitionScaffoldState();
}

class _PageDefinitionScaffoldState extends ConsumerState<AppScaffoldTabPanel> with TickerProviderStateMixin {
  static final log = logger(AppScaffoldTabPanel, level: Level.debug);

  late TabController controller;

  @override
  void initState() {
    super.initState();
    final routeState = ref.read(RouteStateStore.provider);
    log.d('Route State: $routeState');
    controller = TabController(
      length: widget.pageDefinitions.length,
      vsync: this,
      initialIndex: routeState.tab,
      // initialIndex: _calculateInitialTabIndex(widget.pageDefinitions, widget.state),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = widget.pageDefinitions.where((page) => !page.isHidden).toList();
    final primaryColor = Theme.of(context).colorScheme.primary;
    return Column(
      children: [
        ColoredBox(
          color: primaryColor,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: AppScaffoldTabPanelTabs(
              titles: pages.map((p) => p.info.tabTitle).toList(),
              controller: controller,
            ),
          ),
        ),
        Expanded(
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller,
            children: pages
                .map(
                  (page) => AppScaffoldPage(
                    pageDefinition: page,
                    state: widget.state,
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
