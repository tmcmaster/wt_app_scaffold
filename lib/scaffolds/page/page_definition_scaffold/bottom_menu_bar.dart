import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_definition/app_definition.dart';
import 'package:wt_logging/wt_logging.dart';

class BottomMenuBar extends ConsumerWidget {
  static final log = logger(BottomMenuBar);

  final String activeRoute;
  final void Function(int selected, String route)? beforeChange;
  final void Function(String route, BuildContext context, WidgetRef ref) onChange;

  const BottomMenuBar({
    super.key,
    required this.activeRoute,
    this.beforeChange,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final primaryColor = colorScheme.primary;
    final appDefinition = ref.watch(AppDefinition.provider);
    final primaryPages = appDefinition.primaryPages;
    final secondaryPages = appDefinition.secondaryPages;
    final tertiaryPages = appDefinition.tertiaryPages;

    final popupMenuPages = [
      ...secondaryPages,
      ...tertiaryPages,
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            // backgroundColor: const Color(0xFF0D5257),
            selectedItemColor: primaryColor,
            unselectedItemColor: Colors.black,
            iconSize: 16,
            selectedFontSize: 12,
            selectedIconTheme: const IconThemeData(
              size: 16,
            ),
            unselectedIconTheme: const IconThemeData(
              size: 24,
            ),
            unselectedFontSize: 12,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            useLegacyColorScheme: false,
            enableFeedback: false,
            selectedLabelStyle: const TextStyle(
              height: 1.5,
            ),
            items: primaryPages
                .map(
                  (page) => BottomNavigationBarItem(
                    icon: Icon(
                      page.info.icon,
                    ),
                    label: page.info.title,
                    tooltip: page.info.title,
                    // backgroundColor: const Color(0xFF0D5257),
                  ),
                )
                .toList(),
            currentIndex: findCurrentIndex(primaryPages, activeRoute),
            onTap: (selected) {
              // final routeName = createRouteName(pages[selected]);
              final routeName = primaryPages[selected].info.route;
              beforeChange?.call(selected, routeName);
              log.d('Using GoRouter to change page: $routeName');
              onChange(routeName, context, ref);
            },
          ),
        ),
        if (popupMenuPages.isNotEmpty)
          SizedBox(
            height: 64.0,
            child: Card(
              elevation: 4,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              child: PopupMenuButton<PageDefinition>(
                // Callback that sets the selected popup menu item.
                onSelected: (PageDefinition page) {},
                itemBuilder: (BuildContext context) => popupMenuPages
                    .map(
                      (item) => PopupMenuItem<PageDefinition>(
                        value: item,
                        child: SizedBox(
                          width: double.infinity,
                          child: TextButton.icon(
                            style: const ButtonStyle(
                              alignment: Alignment.centerLeft,
                            ),
                            icon: Icon(item.info.icon),
                            label: Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(item.info.title),
                            ),
                            onPressed: () {
                              onChange(item.info.route, context, ref);
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
      ],
    );
  }

  static int findCurrentIndex(List<PageDefinition> pages, String activeRoute) {
    final index = pages.map((p) => p.info.route).toList().indexOf(activeRoute);
    return index < 0 ? 0 : index;
  }
}
