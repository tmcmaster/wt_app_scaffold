import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/models/app_scaffold_typedefs.dart';

mixin AppScaffoldUtils {
  static List<ProviderBase> extractSettingsProvider(AppScaffoldSettingsMapProviders settingsProviders) =>
      settingsProviders.values
          .map(
            (list) => list.map((p) => p.value),
          )
          .expand((e) => e)
          .toList();
}
