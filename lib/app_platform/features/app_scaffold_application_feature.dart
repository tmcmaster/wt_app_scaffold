import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_platform/model/app_scaffold_context_map.dart';
import 'package:wt_app_scaffold/app_platform/model/app_scaffold_feature_definition.dart';
import 'package:wt_app_scaffold/app_platform/model/app_scaffold_override_definition.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/models/app_styles.dart';
import 'package:wt_app_scaffold/providers/app_scaffolds_providers.dart';
import 'package:wt_logging/wt_logging.dart';

// This layer builds the app with the ApplicationDefinition
class AppScaffoldApplicationFeature extends AppScaffoldFeatureDefinition {
  AppScaffoldApplicationFeature(
    AppScaffoldFeatureDefinition? childFeature, {
    required AppDetails appDetails,
    required AppDefinition appDefinition,
    required AppStyles appStyles,
    ApplicationType? applicationType,
  }) : super(
          contextBuilder: (contextMap) async {
            await Future.delayed(const Duration(seconds: 1));
            final AppScaffoldContextMap newContext = {
              ...contextMap,
              AppScaffoldProviders.appDefinition: AppScaffoldOverrideDefinition(
                value: appDefinition,
                override: AppScaffoldProviders.appDefinition.overrideWith(
                  (ref) => appDefinition,
                ),
              ),
              AppScaffoldProviders.appDetails: AppScaffoldOverrideDefinition(
                value: appDetails,
                override: AppScaffoldProviders.appDetails
                    .overrideWith((ref) => appDetails),
              ),
              AppScaffoldProviders.appStyles: AppScaffoldOverrideDefinition(
                value: appDefinition,
                override: AppScaffoldProviders.appStyles.overrideWith(
                  (ref) => appStyles,
                ),
              ),
            };
            return childFeature == null
                ? Future.value(newContext)
                : childFeature.contextBuilder(newContext);
          },
          widgetBuilder: (context, ref) {
            // final appDefinition = ref.read(AppScaffoldProviders.appDefinition);
            // final settingsApplicationType =
            //     ref.watch(ApplicationSettings.applicationType.value);
            // final selectedApplicationType = applicationType ??
            //     appDefinition.applicationType ??
            //     settingsApplicationType;
            // final debugMode = ref.watch(ApplicationSettings.debugMode.value);
            // return selectedApplicationType.builder(appDefinition, debugMode);
            return AppScaffoldApplicationContainer(
              applicationType: applicationType,
            );
          },
          childFeature: childFeature,
        );
}

class AppScaffoldApplicationContainer extends ConsumerWidget {
  static final log =
      logger(AppScaffoldApplicationContainer, level: Level.debug);

  final ApplicationType? applicationType;

  const AppScaffoldApplicationContainer({
    super.key,
    this.applicationType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appDefinition = ref.read(AppScaffoldProviders.appDefinition);
    final settingsApplicationType =
        ref.watch(ApplicationSettings.applicationType.value);
    log.d('App Application Type: $applicationType');
    log.d('Definition Application Type: ${appDefinition.applicationType}');
    log.d('Setting Application Type: $settingsApplicationType');

    final selectedApplicationType = applicationType ??
        appDefinition.applicationType ??
        settingsApplicationType;

    log.d('Selected Application Type: $selectedApplicationType');

    final debugMode = ref.watch(ApplicationSettings.debugMode.value);
    log.d('Debug : $debugMode');
    log.d('Selected Builder : ${selectedApplicationType.builder}');

    return selectedApplicationType.builder(appDefinition, debugMode);
  }
}
