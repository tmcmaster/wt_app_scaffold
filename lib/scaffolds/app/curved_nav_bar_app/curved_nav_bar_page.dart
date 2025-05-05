import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/scaffolds/page/common/app_scaffold_page.dart';
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

    return page == null ? const Scaffold() : AppScaffoldPage(pageDefinition: page!);
    // : page!.createPageContent(
    //     AppScaffoldPageContext(
    //       context: context,
    //       ref: ref,
    //       page: page!,
    //       state: null,
    //     ),
    //   );
  }
}
