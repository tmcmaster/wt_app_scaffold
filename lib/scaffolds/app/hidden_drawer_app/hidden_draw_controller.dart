import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_platform/util/app_scaffold_router.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/providers/app_scaffolds_providers.dart';

class HiddenDrawPageController extends StateNotifier<PageDefinition>
    with AppScaffoldRouter {
  static final page =
      StateNotifierProvider<HiddenDrawPageController, PageDefinition>(
    name: 'HiddenDrawerApp.router',
    (ref) => HiddenDrawPageController(ref),
  );

  static final router = page.notifier;

  static late Map<String, PageDefinition> _pageIndex;

  HiddenDrawPageController(Ref ref)
      : super(ref.read(AppScaffoldProviders.appDefinition).pages.first) {
    _pageIndex = {
      for (final page in ref.read(AppScaffoldProviders.appDefinition).pages)
        page.route: page,
    };
  }

  @override
  void go(String path, {Object? extra}) {
    final newPage = _pageIndex[path];
    if (newPage != null) {
      state = newPage;
    }
  }
}
