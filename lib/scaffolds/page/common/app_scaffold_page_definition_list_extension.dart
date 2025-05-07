import 'package:collection/collection.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';

extension AppScaffoldPageDefinitionListExtension on List<PageDefinition> {
  List<PageDefinition> whereRouteIs(List<String> testRoutes) {
    return where(
      (p) => testRoutes.contains(p.route),
    )
        .map((p) => p.copyWith(primary: true))
        .mapIndexed((i, p) => i == 0
            ? p.copyWith(
                landing: true,
              )
            : p)
        .toList();
  }

  List<PageDefinition> copyWith({
    bool? primary,
    String? homeRoute,
    bool? hideBackButton,
  }) {
    return map((p) => p.copyWith(
          primary: primary,
          homeRoute: homeRoute,
          hideBackButton: hideBackButton,
        )).toList();
  }
}
