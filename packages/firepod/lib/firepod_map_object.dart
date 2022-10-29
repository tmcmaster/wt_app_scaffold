import 'package:firepod/firepod_map.dart';
import 'package:firepod/generic_lookup_map.dart';
import 'package:utils/logging.dart';

class FirepodMapObject<T> extends FirepodMap<T> {
  static final log = logger(FirepodMapObject);

  FirepodMapObject({
    required String name,
    required String prefixPath,
    required T Function(Map<String, dynamic> value) modelDecoder,
    String? keyField,
  }) : super(
          name: name,
          none: GenericLookupMap<T>(map: {}),
          decoder: (value) {
            final map = value as Map<Object?, Object?>;
            final newMap = Map.fromEntries(map.entries.map((e) {
              return MapEntry<String, dynamic>(e.key.toString(), e.value);
            }));
            T model = modelDecoder(newMap);
            return model;
          },
          prefixPath: prefixPath,
          keyField: keyField,
        );
}
