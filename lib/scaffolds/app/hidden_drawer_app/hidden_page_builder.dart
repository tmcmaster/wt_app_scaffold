import 'package:flutter/material.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';

class HiddenPageBuilder extends StatelessWidget {
  final PageDefinition pageDefinition;

  final bool includeAppBar;
  final void Function(BuildContext context)? dismissAction;
  final void Function(BuildContext context)? menuAction;

  const HiddenPageBuilder({
    super.key,
    required this.pageDefinition,
    this.includeAppBar = false,
    this.dismissAction,
    this.menuAction,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return includeAppBar
        ? Scaffold(
            appBar: AppBar(
              title: Text(pageDefinition.title),
              backgroundColor: colorScheme.primary,
              leading: dismissAction == null && menuAction == null ? null : _createIconButton(context),
            ),
            body: pageDefinition.builder(context),
          )
        : pageDefinition.builder(context);
  }

  IconButton? _createIconButton(BuildContext context) {
    return menuAction == null && dismissAction == null
        ? null
        : IconButton(
            icon: Icon(menuAction != null ? Icons.menu : Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              menuAction?.call(context);
            });
  }
}
