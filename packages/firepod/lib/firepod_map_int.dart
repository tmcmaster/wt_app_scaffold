import 'package:firepod/firepod_map.dart';

import 'generic_lookup_map.dart';

class FirepodMapInt extends FirepodMap<int> {
  static const none = GenericLookupMap<int>(map: {});
  FirepodMapInt({
    required String name,
    required String prefixPath,
  }) : super(
          name: name,
          none: none,
          decoder: (value) => int.parse(value.toString()),
          prefixPath: prefixPath,
        );
}
