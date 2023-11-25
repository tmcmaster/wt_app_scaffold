import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/scaffolds/app/bottom_nav_bar_app/page_change_event.dart';
import 'package:wt_app_scaffold/scaffolds/app/bottom_nav_bar_app/page_change_source.dart';

class BottomNavBarSelectedPageNotifier extends StateNotifier<PageChangeEvent> {
  BottomNavBarSelectedPageNotifier(int initialPage)
      : super(
          PageChangeEvent(
            source: PageChangeSource.initial,
            page: initialPage < 0 ? 0 : initialPage,
          ),
        );

  void setPage(PageChangeSource source, int page) {
    if (state.page != page) {
      state = PageChangeEvent(
        source: source,
        page: page,
      );
    }
  }
}
