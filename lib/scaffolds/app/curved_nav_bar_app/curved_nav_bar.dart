import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_logging/wt_logging.dart';

class CurvedNavBar extends ConsumerWidget {
  static final log = logger(CurvedNavBar, level: Level.debug);

  final ValueChanged<int> onChange;
  final int index;
  final List<PageDefinition> pages;
  final GlobalKey<CurvedNavigationBarState> navigationKey;
  const CurvedNavBar({
    super.key,
    required this.navigationKey,
    required this.index,
    required this.pages,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log.d('CurvedNavBar: rebuilding the Curved Nav Bar');

    final items = pages
        .map(
          (definition) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              definition.icon,
              size: 20,
            ),
          ),
        )
        .toList();

    log.d('Number of icons: ${items.length}');
    final validatedIndex = index > items.length - 1 ? 0 : index;

    final colorScheme = Theme.of(context).colorScheme;

    return Theme(
      data: Theme.of(context).copyWith(
        iconTheme: IconThemeData(
          color: colorScheme.onPrimary,
        ),
      ),
      child: CurvedNavigationBar(
        // key: CurvedNavBarApp.navigationKey,
        key: navigationKey,
        color: colorScheme.primary,
        buttonBackgroundColor: colorScheme.primary,
        backgroundColor: Colors.transparent,
        height: 50,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 500),
        index: validatedIndex,
        items: items,
        onTap: (index) => onChange.call(index),
      ),
    );
  }
}
