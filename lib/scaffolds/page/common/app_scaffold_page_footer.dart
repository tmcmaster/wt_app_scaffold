import 'package:flutter/material.dart';

class AppScaffoldPageFooter extends StatelessWidget {
  final Widget? controlsButton;
  final Widget actionsBar;
  final Widget? homeButton;

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
          if (controlsButton != null)
            SizedBox(
              width: 50,
              child: controlsButton,
            ),
          if (controlsButton != null)
            Container(
              color: Colors.grey.shade300,
              width: 2,
              height: 20,
              margin: const EdgeInsets.only(right: 2),
            ),
          Expanded(
            child: actionsBar,
          ),
          if (homeButton != null)
            SizedBox(
              width: 50,
              child: homeButton,
            ),
        ],
      ),
    );
  }
}
