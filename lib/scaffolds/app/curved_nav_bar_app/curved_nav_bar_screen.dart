import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/scaffolds/app/curved_nav_bar_app/curved_nav_bar.dart';
import 'package:wt_app_scaffold/scaffolds/app/curved_nav_bar_app/curved_nav_bar_page.dart';

class CurveNavBarScreen extends ConsumerStatefulWidget {
  const CurveNavBarScreen({
    super.key,
  });

  @override
  ConsumerState<CurveNavBarScreen> createState() => _CurveNavBarScreenState();
}

class _CurveNavBarScreenState extends ConsumerState<CurveNavBarScreen> {
  int index = 0;
  String? route;

  late GlobalKey<CurvedNavigationBarState> navKey =
      GlobalKey<CurvedNavigationBarState>();

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(CurvedNavBarApp.controller.notifier);
    final navigationKey = ref.watch(CurvedNavBarApp.controller);

    if (route != null) {
      final expectedRoute = controller.getPageByIndex(index)?.route;
      if (expectedRoute != route) {
        final newIndex = controller.getIndexByRoute(route!);
        if (newIndex != null) {
          setState(() {
            index = newIndex;
            route = controller.getPageByIndex(newIndex)?.route;
          });
        }
      } else {}
    } else {}

    final pages = controller.getPages();
    final page = controller.getPageByIndex(index);

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: CurvedNavBarPage(
        page: page,
      ),
      bottomNavigationBar: CurvedNavBar(
        navigationKey: navigationKey,
        index: index,
        pages: pages,
        onChange: (newIndex) {
          setState(() {
            index = newIndex;
            route = controller.getPageByIndex(index)?.route;
          });
        },
      ),
    );
  }
}
