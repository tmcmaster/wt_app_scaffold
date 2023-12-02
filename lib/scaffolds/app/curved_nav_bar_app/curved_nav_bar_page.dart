import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/models/app_scaffold_page_context.dart';
import 'package:wt_logging/wt_logging.dart';

class CurvedNavBarPage extends ConsumerWidget {
  static final log = logger(CurvedNavBarPage);

  final PageDefinition? page;
  const CurvedNavBarPage({
    super.key,
    required this.page,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log.d('CurvedNavBarPage: rebuilding the Curved Nav Bar');

    return page == null
        ? const Scaffold()
        : page!.builder(
            AppScaffoldPageContext(
              context: context,
              ref: ref,
              page: page!,
              state: null,
            ),
          );
  }
}
