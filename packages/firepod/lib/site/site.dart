import 'package:wt_models/wt_models.dart';

// TODO: investigate moving back to not needing Site too be in this package.
class Site with IdSupport {
  static final Site none = Site(id: '', name: '-- select a site --');
  final String id;
  final String name;

  Site({required this.id, required this.name});

  @override
  String toString() => 'Site(id: $id, name: $name)';

  @override
  String getId() => id;

  // @override
  // Map<String, dynamic> toJson() {
  //   return {
  //     id: id,
  //     name: name,
  //   };
  // }
}
