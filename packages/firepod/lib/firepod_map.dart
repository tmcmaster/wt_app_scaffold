import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'generic_lookup_map.dart';
import 'generic_lookup_map_notifier.dart';

abstract class FirepodMap<T> {
  late StateNotifierProvider<StateNotifier<GenericLookupMap<T>>, GenericLookupMap<T>> value;

  FirepodMap({
    required String name,
    required GenericLookupMap<T> none,
    required T Function(Object? value) decoder,
    required String prefixPath,
    String? keyField,
  }) {
    value = StateNotifierProvider<StateNotifier<GenericLookupMap<T>>, GenericLookupMap<T>>(
      name: name,
      (ref) => GenericSiteDataNotifier<GenericLookupMap<T>>(
        ref: ref,
        prefixPath: prefixPath,
        decoder: GenericLookupMap.createDecoder<T>((object) => decoder(object), keyField),
        none: none,
      ),
    );
  }

  AlwaysAliveProviderBase<StateNotifier<GenericLookupMap>> get notifier => value.notifier;
}
