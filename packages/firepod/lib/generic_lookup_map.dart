import 'dart:convert';

class GenericLookupMap<T> {
  static const none = GenericLookupMap(map: {});

  final Map<String, T> map;

  const GenericLookupMap({
    required this.map,
  });

  T? value(String key) {
    return map[key];
  }

  T valueOrDefault(String key, T defaultValue) {
    return map[key] ?? defaultValue;
  }

  @override
  String toString() {
    return json.encode(map);
  }

  static GenericLookupMap<T> Function(Object? value) createDecoder<T>(
      T Function(Object? value) decoder, String? keyField) {
    return (Object? value) => GenericLookupMap<T>(
            map: Map.fromEntries((value as Map).entries.map((e) {
          return MapEntry<String, T>(e.key.toString(), decoder(_addKey(e.value, e.key, keyField)));
        })));
  }

  static Object? _addKey(Object? value, String key, String? keyField) {
    if (keyField != null) {
      (value as Map)[keyField] = key;
    }

    return value;
  }
}
