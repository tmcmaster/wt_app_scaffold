import 'package:flutter/material.dart';
import 'package:wt_logging/wt_logging.dart';

class PlaceholderPage extends StatelessWidget {
  static final log = logger(PlaceholderPage);

  static const routeName = 'settings';

  final String title;
  final bool includeAppBar;
  final void Function(BuildContext context)? dismissAction;
  final void Function(BuildContext context)? menuAction;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;

  const PlaceholderPage({
    super.key,
    required this.title,
    this.includeAppBar = false,
    this.dismissAction,
    this.menuAction,
    this.bottomNavigationBar,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: includeAppBar
          ? AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              elevation: 0,
              leading: dismissAction == null && menuAction == null
                  ? null
                  : _createIconButton(context),
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
      bottomNavigationBar: bottomNavigationBar,
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
              log.d('${menuAction == null}');
              //menuAction ?? dismissAction,
            },
          );
  }
}
