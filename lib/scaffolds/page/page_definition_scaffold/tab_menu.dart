import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class TabMenu extends StatefulWidget implements PreferredSizeWidget {
  final List<String> titles;
  final TabController controller;

  const TabMenu({
    super.key,
    required this.titles,
    required this.controller,
  });

  @override
  State<TabMenu> createState() => _TabMenuState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(double.infinity, 20);
}

class _TabMenuState extends State<TabMenu> with TickerProviderStateMixin {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 50,
      ),
      child: TabBar(
        isScrollable: true,
        controller: widget.controller,
        dividerColor: Colors.transparent,
        labelColor: Colors.redAccent,
        tabs: widget.titles
            .mapIndexed(
              (index, title) => Tab(
                height: 24,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: index == selected ? Colors.blue : Colors.white,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0), // Rounded border
          color: Colors.white,
        ),
        onTap: (index) {
          setState(() {
            selected = index;
          });
        },
      ),
    );
  }
}
