import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/models/app_scaffold_page_context.dart';
import 'package:wt_app_scaffold/models/page_builder.dart';
import 'package:wt_app_scaffold/models/scaffold_page_type.dart';
import 'package:wt_app_scaffold/scaffolds/page/common/app_scaffold_page.dart';
import 'package:wt_app_scaffold/scaffolds/page/page_definition_scaffold/page_definition_scaffold.dart';

class ScaffoldPageTypeWrapper extends ConsumerWidget {
  static final scaffoldBuilders = <ScaffoldPageType, AppScaffoldPageBuilder>{
    ScaffoldPageType.plain: _createPlainPage,
    ScaffoldPageType.transparentCard: _createTransparentCard,
  };

  static Widget _createPlainPage(AppScaffoldPageContext pageContext) {
    return AppScaffoldPage(pageDefinition: pageContext.page);
  }

  static Widget _createTransparentCard(AppScaffoldPageContext pageContext) {
    return PageDefinitionScaffold(
      pageDefinition: pageContext.page,
      state: pageContext.state,
    );
  }

  final PageDefinition page;
  final GoRouterState? state;
  final ScaffoldPageType? scaffoldPageType;
  const ScaffoldPageTypeWrapper({
    required this.page,
    this.state,
    this.scaffoldPageType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MediaQueryData data = MediaQuery.of(context);
    final scaleFactor = ref.watch(ApplicationSettings.textScaleFactor.value).value;
    final calculatedScaffoldPageType = page.scaffoldType ?? scaffoldPageType;
    final AppScaffoldPageBuilder pageBuilder = scaffoldBuilders[calculatedScaffoldPageType] ?? _createPlainPage;
    return SafeArea(
      child: MediaQuery(
        data: data.copyWith(
          textScaler: TextScaler.linear(scaleFactor),
        ),
        child: pageBuilder(
          AppScaffoldPageContext(
            context: context,
            ref: ref,
            page: page,
            state: state,
          ),
        ),
      ),
    );
  }
}
