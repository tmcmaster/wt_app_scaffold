import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/action_button_definition.dart';

class AppScaffoldPageButtonBar extends ConsumerWidget {
  const AppScaffoldPageButtonBar({
    super.key,
    required this.actionsProviders,
  });

  final List<ProviderBase<ActionButtonDefinition>> actionsProviders;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
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
