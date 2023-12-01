import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';

class HiddenPageBuilder extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    return includeAppBar
        ? Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(pageDefinition.title),
              backgroundColor: colorScheme.primary,
              leading: _createIconButton(context),
            ),
            body: pageDefinition.builder(context, ref, pageDefinition, null),
          )
        : pageDefinition.builder(context, ref, pageDefinition, null);
  }

  IconButton? _createIconButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.menu),
      color: Colors.white,
      onPressed: () {
        if (menuAction != null) {
          menuAction?.call(context);
        } else {
          HiddenDrawerOpener.of(context)?.open();
        }
      },
    );
  }
}
