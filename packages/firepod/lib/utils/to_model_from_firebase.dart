import 'package:firebase_database/firebase_database.dart';
import 'package:wt_models/wt_models.dart';

class ToModelFromFirebase<T> extends ToModelFrom<T> {
  ToModelFromFirebase({
    required super.json,
    super.titles,
    super.none,
  });

  T snapshot(DataSnapshot snapshot, [String? mapKeyField]) {
    if (snapshot.exists) {
      final map = snapshot.value as Map<dynamic, dynamic>;
      var newMap = {for (var e in map.entries) e.key.toString(): _addKeyFieldIfRequired(e.value, e.key, mapKeyField)};

      return super.json(newMap);
    } else {
      if (super.none != null) {
        return super.none!;
      } else {
        throw Exception('Could not find required firebase object of Type(${T.runtimeType})');
      }
    }
  }

  // TODO: need to test this properly
  Object _addKeyFieldIfRequired(Object value, String key, String? mapKeyField) {
    if (value is Map && mapKeyField != null) {
      value[mapKeyField] = key;
    }
    return value;
  }
}
