import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/scaffolds/app/bottom_nav_bar_app/page_change_event.dart';
import 'package:wt_app_scaffold/scaffolds/app/bottom_nav_bar_app/page_change_source.dart';
import 'package:wt_logging/wt_logging.dart';

class BottomNavBarSelectedPageNotifier extends StateNotifier<PageChangeEvent> {
  static final log =
      logger(BottomNavBarSelectedPageNotifier, level: Level.debug);

  late final Map<String, int> pageIndex;

  BottomNavBarSelectedPageNotifier({
    required List<PageDefinition> pages,
    required int initialPage,
  }) : super(
          PageChangeEvent(
            source: PageChangeSource.initial,
            page: initialPage,
          ),
        ) {
    pageIndex = Map.fromEntries(
      pages.mapIndexed(
        (index, page) => MapEntry(page.route, index),
      ),
    );
  }

  void go(String path) {
    final index = pageIndex[path];
    log.d(
      'Setting page to Path($path) '
      'Index($index): '
      'Source(${PageChangeSource.external.name})',
    );
    if (index != null) {
      state = PageChangeEvent(
        source: PageChangeSource.external,
        page: index,
      );
    }
  }

  void setPage(PageChangeSource source, int page) {
    log.d('Setting page to Index($page): Source(${source.name})');
    if (page >= 0 && page < pageIndex.length) {
      state = PageChangeEvent(
        source: source,
        page: page,
      );
    } else {
      log.w(
        'Could not change to page: '
        'Source(${source.name}), '
        'Index($page)',
      );
    }
  }
}
