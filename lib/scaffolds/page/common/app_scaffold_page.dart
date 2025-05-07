import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wt_app_scaffold/models/app_scaffold_page_context.dart';
import 'package:wt_app_scaffold/models/page_definition.dart';
import 'package:wt_app_scaffold/scaffolds/page/common/app_scaffold_page_button_bar.dart';
import 'package:wt_app_scaffold/scaffolds/page/common/app_scaffold_page_content.dart';
import 'package:wt_app_scaffold/scaffolds/page/common/app_scaffold_page_drawer.dart';
import 'package:wt_app_scaffold/scaffolds/page/common/app_scaffold_page_drawer_button.dart';
import 'package:wt_app_scaffold/scaffolds/page/common/app_scaffold_page_footer.dart';
import 'package:wt_app_scaffold/scaffolds/page/common/app_scaffold_page_header.dart';
import 'package:wt_app_scaffold/scaffolds/page/common/app_scaffold_page_home_button.dart';
import 'package:wt_app_scaffold/scaffolds/page/common/app_scaffold_page_indicators.dart';
import 'package:wt_logging/wt_logging.dart';

class AppScaffoldPage extends ConsumerStatefulWidget {
  final PageDefinition pageDefinition;
  final GoRouterState? state;
  final bool scrollable;

  const AppScaffoldPage({
    super.key,
    required this.pageDefinition,
    this.state,
    this.scrollable = false,
  });

  @override
  ConsumerState<AppScaffoldPage> createState() => _AppScaffoldPageState();
}

class _AppScaffoldPageState extends ConsumerState<AppScaffoldPage> {
  static final log = logger(AppScaffoldPage, level: Level.debug);

  @override
  Widget build(BuildContext context) {
    final pageContext = AppScaffoldPageContext(
      context: context,
      ref: ref,
      page: widget.pageDefinition,
    );

    final textTheme = Theme.of(context).textTheme;
    final actionsProviders = widget.pageDefinition.actionsProviders;
    final settingsProviders = widget.pageDefinition.settingsProviders;
    final pageTitle = widget.pageDefinition.pageInfo.tabTitle;
    final pageIcon = widget.pageDefinition.pageInfo.icon;
    final pageContentBuilder = widget.pageDefinition.pageContentBuilder;
    final pageBuilder = widget.pageDefinition.pageBuilder;
    final homeRoute = widget.pageDefinition.homeRoute;
    final hasSettings = settingsProviders.isNotEmpty;

    return pageBuilder?.call(pageContext) ??
        AppScaffoldPageContent(
          scrollable: widget.scrollable,
          header: AppScaffoldPageHeader(
            icon: Icon(pageIcon),
            title: Text(
              pageTitle,
              textAlign: TextAlign.left,
              style: textTheme.titleLarge,
            ),
            indicators: AppScaffoldPageIndicators(actionsProviders: actionsProviders),
          ),
          body: pageContentBuilder?.call(pageContext) ??
              Center(
                child: Text(pageTitle),
              ),
          drawer: AppScaffoldPageDrawer(
            settingsProviders: settingsProviders,
          ),
          footerBuilder: (context) => AppScaffoldPageFooter(
            controlsButton: hasSettings ? const AppScaffoldPageDrawerButton() : null,
            actionsBar: AppScaffoldPageButtonBar(actionsProviders: actionsProviders),
            homeButton: AppScaffoldPageHomeButton(homeRoute: homeRoute),
          ),
        );
  }
}
