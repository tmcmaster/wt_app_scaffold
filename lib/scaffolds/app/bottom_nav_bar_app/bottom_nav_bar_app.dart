import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_logging/wt_logging.dart';

class BottomNavBarApp extends StatefulWidget {
  final AppDefinition appDefinition;
  final bool debugMode;

  const BottomNavBarApp._({
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
  late StateNotifierProvider<_SelectedPageNotifier, PageChangeEvent>
      _selectedPageProvider;

  @override
  void initState() {
    final initialIndex = widget.appDefinition.pages
        .indexOf(widget.appDefinition.pages.firstWhere((page) => page.primary));

    _selectedPageProvider =
        StateNotifierProvider<_SelectedPageNotifier, PageChangeEvent>(
      (ref) => _SelectedPageNotifier(initialIndex),
    );

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
        debugMode: widget.debugMode,
        swipeEnabled: widget.appDefinition.swipeEnabled,
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
  _SelectedPageNotifier(int initialPage)
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

class _PageView extends ConsumerStatefulWidget {
  final List<PageDefinition> items;
  final bool swipeEnabled;
  final bool debugMode;
  final StateNotifierProvider<_SelectedPageNotifier, PageChangeEvent> provider;
  const _PageView({
    required this.items,
    required this.provider,
    required this.debugMode,
    this.swipeEnabled = true,
  });

  @override
  ConsumerState<_PageView> createState() => _PageViewState();
}

class _PageViewState extends ConsumerState<_PageView> {
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
      itemBuilder: (context, index) =>
          filterItems[index].builder(context, filterItems[index], null),
      onPageChanged: (page) {
        final pageNav = ref.read(widget.provider.notifier);
        pageNav.setPage(PageChangeSource.pageView, page);
      },
      controller: pageController,
    );
  }
}

// This is the type used by the popup menu below.
// enum Menu { itemOne, itemTwo, itemThree, itemFour }

class _BottomNavigationBar extends ConsumerWidget {
  static final log = logger(_BottomNavigationBar);

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

    final primaryItems = items.where((item) => item.primary).toList();
    final otherItems = items.where((item) => !item.primary).toList();
    log.d('Total Items: ${items.length}');
    log.d('Primary Items: ${primaryItems.length}');
    log.d('Other Items: ${otherItems.length}');

    final primaryColor = Theme.of(context).primaryColor;

    final currentSelected = pageChangeEvent.page < items.length
        ? primaryItems.indexOf(items[pageChangeEvent.page])
        : -1;
    log.d('Selected Primary: $currentSelected');

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          flex: 1,
          child: BottomNavigationBar(
            enableFeedback: false,
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            unselectedItemColor: Colors.grey.shade500,
            selectedItemColor: primaryColor,
            selectedIconTheme: IconThemeData(
              color: primaryColor,
            ),
            unselectedIconTheme: IconThemeData(
              color: Colors.grey.shade500,
            ),
            iconSize: 20,
            items: primaryItems
                .where((item) => !item.debug)
                .map(
                  (item) => BottomNavigationBarItem(
                    icon: Icon(
                      item.icon,
                    ),
                    label: item.title,
                  ),
                )
                .toList(),
            onTap: (selection) {
              log.d('Selected Item: $selection');
              final index = items.indexOf(primaryItems[selection]);
              log.d('Calculated Index: $index');
              pageNav.setPage(PageChangeSource.buttonBar, index);
            },
            currentIndex: currentSelected < 0 ? 0 : currentSelected,
          ),
        ),
        if (otherItems.isNotEmpty)
          PopupMenuButton<PageDefinition>(
            // Callback that sets the selected popup menu item.
            onSelected: (PageDefinition page) {},
            itemBuilder: (BuildContext context) => otherItems
                .map(
                  (item) => PopupMenuItem<PageDefinition>(
                    value: item,
                    child: SizedBox(
                      width: double.infinity,
                      child: TextButton.icon(
                        style: const ButtonStyle(
                          alignment: Alignment.centerLeft,
                        ),
                        icon: Icon(item.icon),
                        label: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(item.title),
                        ),
                        onPressed: () {
                          pageNav.setPage(
                            PageChangeSource.buttonBar,
                            items.indexOf(item),
                          );
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }
}
