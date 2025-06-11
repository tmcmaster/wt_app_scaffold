import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_definition/app_definition.dart';
import 'package:wt_app_scaffold/scaffolds/common/types/app_scaffold_router.dart';

class HiddenDrawPageController extends StateNotifier<PageDefinition> with AppScaffoldRouter {
  static final page = StateNotifierProvider<HiddenDrawPageController, PageDefinition>(
    name: 'HiddenDrawerApp.router',
    (ref) => HiddenDrawPageController(ref),
  );

  static final router = page.notifier;

  static late Map<String, PageDefinition> _pageIndex;

  HiddenDrawPageController(Ref ref) : super(getLandingPage(ref)) {
    _pageIndex = {
      for (final page in ref.read(AppDefinition.provider).pages) page.info.route: page,
    };
  }

  static PageDefinition getLandingPage(Ref ref) {
    final appDefinition = ref.read(AppDefinition.provider);
    return appDefinition.pages.firstWhere((page) => page.isLanding, orElse: () => appDefinition.pages.first);
  }

  @override
  void push(String path, {Object? extra}) {
    go(path, extra: extra);
  }

  @override
  void go(String path, {Object? extra}) {
    final newPage = _pageIndex[path];
    if (newPage != null) {
      state = newPage;
    }
  }
}
