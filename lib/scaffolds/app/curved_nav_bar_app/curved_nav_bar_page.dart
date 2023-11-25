import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_logging/wt_logging.dart';

class CurvedNavBarPage extends ConsumerWidget {
  static final log = logger(CurvedNavBarPage);

  final int index;
  const CurvedNavBarPage({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(CurvedNavBarApp.controller.notifier);

    log.d('CurvedNavBarPage: rebuilding the Curved Nav Bar');

    final pageCount = controller.getPages().length;
    final validatedIndex = index > pageCount - 1 ? 0 : index;
    final page = controller.getPageByIndex(validatedIndex);
    return page == null ? const Scaffold() : page.builder(context, page, null);
  }
}
