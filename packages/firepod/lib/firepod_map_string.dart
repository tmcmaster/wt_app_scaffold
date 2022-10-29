import 'package:firepod/firepod_map.dart';

import 'generic_lookup_map.dart';

class FirepodMapString extends FirepodMap<String> {
  static const none = GenericLookupMap<String>(map: {});
  FirepodMapString({
    required String name,
    required String prefixPath,
  }) : super(
          name: name,
          none: none,
          decoder: (value) => value.toString(),
          prefixPath: prefixPath,
        );
}
