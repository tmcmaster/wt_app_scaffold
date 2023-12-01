import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppScaffoldOverrideDefinition<T> {
  final Override override;
  final T value;

  AppScaffoldOverrideDefinition({
    required this.value,
    required this.override,
  });
}
