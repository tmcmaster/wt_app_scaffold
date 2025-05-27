import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/models/app_scaffold_typedefs.dart';
import 'package:wt_provider_manager/wt_provider_manager.dart';

mixin AppScaffoldUtils {
  static List<ProviderBase> extractSettingsProvider(AppScaffoldSettingsMapProviders settingsProviders) =>
      settingsProviders.values
          .map(
            (list) => list.map((p) => p.value),
          )
          .expand((e) => e)
          .toList();
}

extension AppScaffoldSettingsMapProvidersListExtension on List<AppScaffoldSettingsMapProviders> {
  List<SettingsInitialiser> toSettingInitialisers() => map(
        (appScaffoldSettingsMapProviders) => AppScaffoldUtils.extractSettingsProvider(
          appScaffoldSettingsMapProviders,
        ),
      ).expand((e) => e).map((provider) => SettingsInitialiser(provider: provider)).toList();
}
