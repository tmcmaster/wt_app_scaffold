import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_definition/app_definition.dart';

class AppScaffoldPageButtonBar extends ConsumerWidget {
  final List<ProviderBase<ActionDefinition>> actionsProviders;

  const AppScaffoldPageButtonBar({
    super.key,
    required this.actionsProviders,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Wrap(
      children: actionsProviders
          .map(
            (provider) => ref.read(provider).component(
                  noLabel: true,
                  color: Colors.black,
                ),
          )
          .toList(),
    );
  }
}
