import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wt_app_scaffold/models/page_definition.dart';
import 'package:wt_app_scaffold/providers/app_scaffolds_providers.dart';

class BottomMenuBar extends ConsumerWidget {
  final String activeRoute;
  final void Function(int selected)? beforeTransition;

  static final menuPages = [
    '/market',
    '/account',
    '/sell',
    '/messages',
    '/about',
  ];

  const BottomMenuBar({
    super.key,
    required this.activeRoute,
    this.beforeTransition,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appDefinition = ref.read(AppScaffoldProviders.appDefinition);
    final pages = appDefinition.pages.where((page) => page.primary).toList();
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      // backgroundColor: const Color(0xFF0D5257),
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey.shade400,
      iconSize: 16,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      useLegacyColorScheme: false,
      enableFeedback: false,
      selectedLabelStyle: const TextStyle(height: 1.5),
      items: appDefinition.pages
          .where((page) => page.primary)
          .map(
            (page) => BottomNavigationBarItem(
              icon: Icon(
                page.icon,
              ),
              label: page.title,
              backgroundColor: const Color(0xFF0D5257),
            ),
          )
          .toList(),
      currentIndex: findCurrentIndex(pages, activeRoute),
      onTap: (selected) {
        final routeName = createRouteName(pages[selected]);
        beforeTransition?.call(selected);
        context.go(routeName);
      },
    );
  }

  static int findCurrentIndex(List<PageDefinition> pages, String activeRoute) {
    final index =
        pages.map((p) => createRouteName(p)).toList().indexOf(activeRoute);
    return index < 0 ? 0 : index;
  }

  static String createRouteName(PageDefinition page) {
    return '/${page.title.toLowerCase()}';
  }
}
