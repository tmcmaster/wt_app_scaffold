import 'package:flutter/material.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final backgroundColor = colorScheme.secondary;
    final foregroundColor = colorScheme.onSecondary;

    return SliverPageScaffold(
      pinnedHeader: true,
      appBarColor: backgroundColor,
      collapsedHeight: 60,
      header: Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.menu,
                color: foregroundColor,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.menu,
                color: foregroundColor,
              ),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.blue,
                backgroundColor: Colors.white,
              ),
              onPressed: () {},
              child: const Text(
                'Test 3',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings,
                color: foregroundColor,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 300,
            width: 300,
            color: Colors.blue.withOpacity(0.5),
          ),
          Container(
            height: 300,
            width: 300,
            color: Colors.yellow.withOpacity(0.5),
          ),
          Container(
            height: 300,
            width: 300,
            color: Colors.orange.withOpacity(0.5),
          ),
        ],
      ),
      footer: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OutlinedButton(
              onPressed: () {},
              child: const Text('Test'),
            ),
            OutlinedButton(
              onPressed: () {},
              child: const Text('Test'),
            ),
          ],
        ),
      ),
    );
  }
}
