import 'package:firepod/generic_lookup_map_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FirepodObject<T> {
  late StateNotifierProvider<StateNotifier<T>, T> value;

  FirepodObject({
    required String name,
    required T none,
    required T Function(Map<dynamic, dynamic> value) decoder,
    required String prefixPath,
  }) {
    value = StateNotifierProvider<StateNotifier<T>, T>(
      name: name,
      (ref) => GenericSiteDataNotifier<T>(
        ref: ref,
        prefixPath: prefixPath,
        decoder: (value) => value == null ? none : decoder(value as Map<dynamic, dynamic>),
        none: none,
      ),
    );
  }

  AlwaysAliveRefreshable<StateNotifier<T>> get notifier => value.notifier;
}
