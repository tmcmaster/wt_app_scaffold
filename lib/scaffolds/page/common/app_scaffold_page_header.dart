import 'package:flutter/material.dart';

class AppScaffoldPageHeader extends StatelessWidget {
  final Widget icon;
  final Widget title;
  final Widget indicators;

  const AppScaffoldPageHeader({
    super.key,
    required this.icon,
    required this.title,
    required this.indicators,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 50,
            child: icon,
          ),
          title,
          const Spacer(),
          indicators,
        ],
      ),
    );
  }
}
