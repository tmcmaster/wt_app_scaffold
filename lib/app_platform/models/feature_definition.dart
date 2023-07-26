import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_platform/models/provider_override_definition.dart';

class FeatureDefinition {
  final Future<Map<ProviderListenable, ProviderOverrideDefinition>> Function(
    Map<ProviderListenable, ProviderOverrideDefinition> contextMap,
  ) initialiser;
  final Widget Function(WidgetRef ref) builder;

  FeatureDefinition({
    required this.initialiser,
    required this.builder,
  });
}
