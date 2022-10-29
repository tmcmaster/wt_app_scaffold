import 'dart:convert' as convert show json;

import 'package:csv/csv.dart';

import 'json_support.dart';

class FromModelTo<T extends JsonSupport> {
  static const _listToCsv = ListToCsvConverter(delimitAllFields: true);

  late List<String> _titles;

  FromModelTo({
    List<String>? titles,
  }) {
    _titles = titles ?? [];
  }

  List<dynamic> toCsvFromJsonMap(Map<String, dynamic> json) {
    return _titles.map((key) => json[key]).toList();
  }

  Map<String, dynamic> jsonFromModel(T model) {
    return model.toJson();
  }

  String jsonStringFromMode(T model) {
    return convert.json.encode(model.toJson());
  }

  List<Map<String, dynamic>> jsonListFromModelList(List<T> models) {
    return models.map((model) => model.toJson()).toList();
  }

  String jsonStringFromModelList(List<T> modelList) {
    return convert.json.encode(modelList.map((model) => model.toJson()).toList());
  }

  List<dynamic> csvFromModel(T model) {
    final json = model.toJson();
    return _titles.map((title) => json[title]).toList();
  }

  List<List<dynamic>> csvListModelList(List<T> models) {
    final csvList = models.map((model) => toCsvFromJsonMap(model.toJson())).toList();
    return [
      _titles,
      ...csvList,
    ];
  }

  List<List<dynamic>> csvListFromJsonList(List<Map<String, dynamic>> jsonList) {
    final csvList = jsonList.map((json) => toCsvFromJsonMap(json)).toList();
    return [
      _titles,
      ...csvList,
    ];
  }
}
