import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';

class BottomNavBarApp extends StatefulWidget {
  final AppDefinition appDefinition;
  final bool debugMode;

  const BottomNavBarApp._({
    super.key,
    required this.appDefinition,
    required this.debugMode,
  });

  factory BottomNavBarApp.build(
    AppDefinition appDefinition,
    bool debugMode,
  ) {
    return BottomNavBarApp._(
      appDefinition: appDefinition,
      debugMode: debugMode,
    );
  }

  @override
  State<BottomNavBarApp> createState() => _BottomNavBarAppState();
}

class _BottomNavBarAppState extends State<BottomNavBarApp> {
  late StateNotifierProvider<_SelectedPageNotifier, PageChangeEvent> _selectedPageProvider;

  @override
  void initState() {
    _selectedPageProvider =
        StateNotifierProvider<_SelectedPageNotifier, PageChangeEvent>((ref) => _SelectedPageNotifier());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.appDefinition.pages.where((page) {
      return widget.debugMode || !page.debug;
    }).toList();

    return Scaffold(
      body: _PageView(
        items: items,
        swipEnabled: widget.appDefinition.swipeEnabled,
        provider: _selectedPageProvider,
      ),
      bottomNavigationBar: _BottomNavigationBar(
        items: items,
        provider: _selectedPageProvider,
      ),
    );
  }
}

class _SelectedPageNotifier extends StateNotifier<PageChangeEvent> {
  _SelectedPageNotifier()
      : super(PageChangeEvent(
          source: PageChangeSource.initial,
          page: 0,
        ));

  void setPage(PageChangeSource source, int page) {
    if (state.page != page) {
      state = PageChangeEvent(
        source: source,
        page: page,
      );
    }
  }
}

enum PageChangeSource {
  initial,
  buttonBar,
  pageView;
}

class PageChangeEvent {
  final PageChangeSource source;
  final int page;

  PageChangeEvent({
    required this.source,
    required this.page,
  });
}

class _PageView extends HookConsumerWidget {
  final List<PageDefinition> items;
  final bool swipEnabled;
  final StateNotifierProvider<_SelectedPageNotifier, PageChangeEvent> provider;
  _PageView({
    required this.items,
    required this.provider,
    this.swipEnabled = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = usePageController();
    ref.listen(provider, (_, PageChangeEvent next) {
      if (next.source != PageChangeSource.pageView) {
        pageController.animateToPage(
          next.page,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });

    return PageView.builder(
      itemCount: items.length,
      physics: swipEnabled ? null : NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => items[index].builder(context),
      onPageChanged: (page) {
        final pageNav = ref.read(provider.notifier);
        pageNav.setPage(PageChangeSource.pageView, page);
      },
      controller: pageController,
    );
  }
}

class _BottomNavigationBar extends ConsumerWidget {
  final List<PageDefinition> items;
  final StateNotifierProvider<_SelectedPageNotifier, PageChangeEvent> provider;

  const _BottomNavigationBar({
    required this.items,
    required this.provider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageChangeEvent = ref.watch(provider);
    final pageNav = ref.read(provider.notifier);
    return BottomNavigationBar(
      iconSize: 20,
      type: BottomNavigationBarType.fixed,
      items: items
          .map((item) => BottomNavigationBarItem(
                icon: Icon(item.icon),
                label: item.title,
              ))
          .toList(),
      onTap: (selection) {
        pageNav.setPage(PageChangeSource.buttonBar, selection);
      },
      currentIndex: pageChangeEvent.page,
    );
  }
}
