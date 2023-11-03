import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';

mixin AppScaffoldProviders {
  static final appDefinition = Provider<AppDefinition>(
    name: 'AppScaffoldProviders.appAppDefinition',
    (ref) => throw Exception(
      'AppScaffoldProviders.appAppDefinition provider needs to be overridden.',
    ),
  );

  static final applicationType = Provider(
    name: 'AppScaffoldProviders.applicationType',
    (ref) {
      final applicationDefinition =
          ref.read(AppScaffoldProviders.appDefinition);
      final settingsApplicationType =
          ref.watch(ApplicationSettings.applicationType.value);
      final staticApplicationType = applicationDefinition.applicationType;
      final applicationType = staticApplicationType ?? settingsApplicationType;
      return applicationType;
    },
  );
}
