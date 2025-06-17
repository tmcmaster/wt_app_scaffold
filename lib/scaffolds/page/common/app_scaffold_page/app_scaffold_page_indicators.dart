import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_definition/app_definition.dart';

class AppScaffoldPageIndicators extends ConsumerWidget {
  final List<ProviderBase<ActionDefinition>> actionsProviders;

  const AppScaffoldPageIndicators({
    super.key,
    required this.actionsProviders,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Wrap(
      alignment: WrapAlignment.end,
      children: actionsProviders
          .map(
            (provider) => ref.read(provider).statusIcon(),
          )
          .toList(),
    );
  }
}
