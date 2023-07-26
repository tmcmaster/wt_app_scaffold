import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProviderOverrideDefinition<T> {
  final Override override;
  final T value;

  ProviderOverrideDefinition({
    required this.value,
    required this.override,
  });
}
