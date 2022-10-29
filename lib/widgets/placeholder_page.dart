import 'package:flutter/material.dart';

class PlaceholderPage extends StatelessWidget {
  static const routeName = 'settings';

  final String title;
  final bool includeAppBar;
  final void Function(BuildContext context)? dismissAction;
  final void Function(BuildContext context)? menuAction;

  const PlaceholderPage({
    super.key,
    required this.title,
    this.includeAppBar = false,
    this.dismissAction,
    this.menuAction,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: includeAppBar
          ? AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              elevation: 0,
              leading: dismissAction == null && menuAction == null ? null : _createIconButton(context),
              title: Text(title),
            )
          : null,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 60,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Text(
              'Work in Progress',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconButton? _createIconButton(BuildContext context) {
    return menuAction == null && dismissAction == null
        ? null
        : IconButton(
            icon: Icon(menuAction != null ? Icons.menu : Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              menuAction?.call(context);
              print('${menuAction == null}');
              //menuAction ?? dismissAction,
            });
  }
}
