import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/scaffolds/app/bottom_nav_bar_app/bottom_nav_bar_selected_page_notifier.dart';
import 'package:wt_app_scaffold/scaffolds/app/bottom_nav_bar_app/page_change_event.dart';
import 'package:wt_app_scaffold/scaffolds/app/bottom_nav_bar_app/page_change_source.dart';
import 'package:wt_logging/wt_logging.dart';

class BottomNavBarMenu extends ConsumerWidget {
  static final log = logger(BottomNavBarMenu);

  final List<PageDefinition> items;
  final StateNotifierProvider<BottomNavBarSelectedPageNotifier, PageChangeEvent>
      provider;

  const BottomNavBarMenu({
    required this.items,
    required this.provider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageChangeEvent = ref.watch(provider);
    final pageNav = ref.read(provider.notifier);
    final debugMode = ref.read(ApplicationSettings.debugMode.value);
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
                .where((item) => debugMode || !item.debug)
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
