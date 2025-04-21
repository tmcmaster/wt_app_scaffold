import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class TabMenu extends StatefulWidget implements PreferredSizeWidget {
  final List<String> titles;
  final TabController controller;
  final bool indicatorBackground;
  const TabMenu({
    super.key,
    required this.titles,
    required this.controller,
    this.indicatorBackground = false,
  });

  @override
  State<TabMenu> createState() => _TabMenuState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(double.infinity, 20);
}

class _TabMenuState extends State<TabMenu> with TickerProviderStateMixin {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: true,
      controller: widget.controller,
      dividerColor: Colors.transparent,
      labelColor: Colors.redAccent,
      tabAlignment: TabAlignment.center,
      indicatorColor: widget.indicatorBackground ? null : Colors.white,
      tabs: widget.titles
          .mapIndexed(
            (index, title) => Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Tab(
                height: 24,
                child: Text(
                  title,
                  style: TextStyle(
                    color: widget.indicatorBackground
                        ? index == selected
                            ? Colors.blue
                            : Colors.white
                        : Colors.white,
                  ),
                ),
              ),
            ),
          )
          .toList(),
      indicator: widget.indicatorBackground
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(4.0), // Rounded border
              color: Colors.white,
            )
          : null,
      onTap: (index) {
        setState(() {
          selected = index;
        });
      },
    );
  }
}
