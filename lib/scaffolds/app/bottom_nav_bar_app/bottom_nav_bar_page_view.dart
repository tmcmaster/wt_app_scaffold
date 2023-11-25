import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/scaffolds/app/bottom_nav_bar_app/bottom_nav_bar_selected_page_notifier.dart';
import 'package:wt_app_scaffold/scaffolds/app/bottom_nav_bar_app/page_change_event.dart';
import 'package:wt_app_scaffold/scaffolds/app/bottom_nav_bar_app/page_change_source.dart';

class BottomNavBarPageView extends ConsumerStatefulWidget {
  final List<PageDefinition> items;
  final bool swipeEnabled;
  final bool debugMode;
  final StateNotifierProvider<BottomNavBarSelectedPageNotifier, PageChangeEvent>
      provider;
  const BottomNavBarPageView({
    required this.items,
    required this.provider,
    required this.debugMode,
    this.swipeEnabled = true,
  });

  @override
  ConsumerState<BottomNavBarPageView> createState() => _PageViewState();
}

class _PageViewState extends ConsumerState<BottomNavBarPageView> {
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(widget.provider, (_, PageChangeEvent next) {
      if (next.source != PageChangeSource.pageView) {
        pageController.animateToPage(
          next.page,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });

    final filterItems = widget.debugMode
        ? widget.items
        : widget.items.where((item) => !item.debug).toList();
    return PageView.builder(
      itemCount: filterItems.length,
      physics:
          widget.swipeEnabled ? null : const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => filterItems[index].builder(
        context,
        filterItems[index],
        null,
      ),
      onPageChanged: (page) {
        final pageNav = ref.read(widget.provider.notifier);
        pageNav.setPage(PageChangeSource.pageView, page);
      },
      controller: pageController,
    );
  }
}
