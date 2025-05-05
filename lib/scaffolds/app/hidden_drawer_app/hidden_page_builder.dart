import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/models/scaffold_page_type.dart';
import 'package:wt_app_scaffold/scaffolds/page/page_definition_scaffold/scaffold_page_type_wrapper.dart';
import 'package:wt_logging/wt_logging.dart';

class HiddenPageBuilder extends ConsumerWidget {
  static final log = logger(HiddenPageBuilder, level: Level.debug);

  final PageDefinition pageDefinition;
  final ScaffoldPageType? pageType;
  final bool includeAppBar;
  final void Function(BuildContext context)? dismissAction;
  final void Function(BuildContext context)? menuAction;

  const HiddenPageBuilder({
    super.key,
    required this.pageDefinition,
    this.pageType,
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
              title: Text(pageDefinition.pageInfo.title),
              backgroundColor: colorScheme.primary,
              leading: _createIconButton(context),
            ),
            body: ScaffoldPageTypeWrapper(
              page: pageDefinition,
              scaffoldPageType: pageType,
            ),
          )
        : ScaffoldPageTypeWrapper(
            page: pageDefinition,
            scaffoldPageType: pageType,
          );
  }

  IconButton? _createIconButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.menu),
      color: Colors.white,
      onPressed: () {
        if (menuAction != null) {
          menuAction?.call(context);
        } else {
          final opener = HiddenDrawerOpener.of(context);
          log.d(opener);
          opener?.open();
        }
      },
    );
  }
}
