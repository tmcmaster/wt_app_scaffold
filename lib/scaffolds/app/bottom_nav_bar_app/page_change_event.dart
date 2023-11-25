import 'package:wt_app_scaffold/scaffolds/app/bottom_nav_bar_app/page_change_source.dart';

class PageChangeEvent {
  final PageChangeSource source;
  final int page;

  PageChangeEvent({
    required this.source,
    required this.page,
  });
}
