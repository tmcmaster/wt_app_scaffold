import 'package:flutter/material.dart';

class AppScaffoldPageFooter extends StatelessWidget {
  final Widget controlsButton;
  final Widget actionsBar;
  final Widget homeButton;

  const AppScaffoldPageFooter({
    super.key,
    required this.controlsButton,
    required this.actionsBar,
    required this.homeButton,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 50,
            child: controlsButton,
          ),
          Expanded(
            child: actionsBar,
          ),
          SizedBox(
            width: 50,
            child: homeButton,
          ),
        ],
      ),
    );
  }
}
