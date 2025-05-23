import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/models/page_definition.dart';
import 'package:wt_app_scaffold/providers/app_scaffolds_providers.dart';
import 'package:wt_logging/wt_logging.dart';

class BottomMenuBar extends ConsumerWidget {
  static final log = logger(BottomMenuBar, level: Level.debug);

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
    final appDefinition = ref.read(AppScaffoldProviders.appDefinition);
    final pages = appDefinition.pages.where((page) => page.primary).toList();
    final colorScheme = Theme.of(context).colorScheme;
    final primaryColor = colorScheme.primary;
    return BottomNavigationBar(
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
      items: appDefinition.pages
          .where((page) => page.primary)
          .map(
            (page) => BottomNavigationBarItem(
              icon: Icon(
                page.pageInfo.icon,
              ),
              label: page.pageInfo.title,
              tooltip: page.pageInfo.title,
              backgroundColor: const Color(0xFF0D5257),
            ),
          )
          .toList(),
      currentIndex: findCurrentIndex(pages, activeRoute),
      onTap: (selected) {
        // final routeName = createRouteName(pages[selected]);
        final routeName = pages[selected].route;
        beforeChange?.call(selected, routeName);
        log.d('Using GoRouter to change page: $routeName');
        onChange(routeName, context, ref);
      },
    );
  }

  static int findCurrentIndex(List<PageDefinition> pages, String activeRoute) {
    final index = pages.map((p) => p.route).toList().indexOf(activeRoute);
    return index < 0 ? 0 : index;
  }
}
