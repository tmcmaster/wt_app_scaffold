import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wt_app_definition/app_definition.dart';
import 'package:wt_app_scaffold/app_platform/model/app_scaffold_context_map.dart';
import 'package:wt_app_scaffold/app_platform/model/app_scaffold_feature_definition.dart';
import 'package:wt_app_scaffold/app_platform/model/app_scaffold_override_definition.dart';
import 'package:wt_app_scaffold/app_platform/scaffold_app_dsl.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_logging/wt_logging.dart';
import 'package:wt_workflow_tree/workflow_tree.dart';

// This layer builds the app with the ApplicationDefinition
class AppScaffoldApplicationFeature extends AppScaffoldFeatureDefinition {
  AppScaffoldApplicationFeature(
    AppScaffoldFeatureDefinition? childFeature, {
    required AppDefinition appDefinition,
    required ProviderBuilder<AppStyles> appStyles,
    ApplicationType? applicationType,
  }) : super(
          contextBuilder: (contextMap) async {
            await Future.delayed(const Duration(seconds: 1));
            final adjustedAppDefinition = appDefinition.workflows.isEmpty
                ? appDefinition
                : appDefinition.copyWith(
                    pages: [
                      PageDefinition(
                        info: PageInfo(
                          icon: FontAwesomeIcons.tree,
                          title: 'Workflow',
                        ),
                        pageBuilder: (_) => WorkflowTreePage(
                          routerProvider: AppScaffoldStore.router,
                        ),
                        showAppBar: false,
                        pageType: AppScaffoldPageType.transparentCard,
                      ).copyWith(
                        itemType: ItemType.primary,
                        pageType: AppScaffoldPageType.transparentCard,
                        landing: true,
                        showBottomMenu: true,
                      ),
                      ...appDefinition.getPages(recursive: false),
                    ],
                  );
            final AppScaffoldContextMap newContext = {
              ...contextMap,
              AppDefinition.provider: AppScaffoldOverrideDefinition(
                value: adjustedAppDefinition,
                override: AppDefinition.provider.overrideWith(
                  (ref) {
                    return adjustedAppDefinition;
                  },
                ),
              ),
              AppScaffoldStore.specifiedApplicationType: AppScaffoldOverrideDefinition(
                value: applicationType,
                override: AppScaffoldStore.specifiedApplicationType.overrideWith((ref) => applicationType),
              ),
              AppScaffoldStore.appDetails: AppScaffoldOverrideDefinition(
                value: appDefinition.appDetails,
                override: AppScaffoldStore.appDetails.overrideWith((ref) => appDefinition.appDetails),
              ),
              AppScaffoldStore.appStyles: AppScaffoldOverrideDefinition(
                value: appStyles,
                override: AppScaffoldStore.appStyles.overrideWith(appStyles),
              ),
            };
            return childFeature == null ? Future.value(newContext) : childFeature.contextBuilder(newContext);
          },
          widgetBuilder: (context, ref) {
            return AppScaffoldApplicationContainer(applicationType: applicationType);
          },
          childFeature: childFeature,
        );
}

class AppScaffoldApplicationContainer extends ConsumerWidget {
  static final log = logger(AppScaffoldApplicationContainer);

  final ApplicationType? applicationType;
  const AppScaffoldApplicationContainer({
    super.key,
    this.applicationType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appDefinition = ref.read(AppDefinition.provider);

    final ApplicationType type = applicationType ?? ref.watch(AppScaffoldStore.applicationType);

    final debugMode = ref.watch(ApplicationSettings.debugMode.value);
    log.d('Debug : $debugMode');
    log.d('Application Type: $type');

    return type.builder(appDefinition, debugMode);
  }
}
