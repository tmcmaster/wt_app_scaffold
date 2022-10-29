import 'dart:convert' as convert show json;
import 'dart:io';

import 'package:csv/csv.dart';

class ToModelFrom<T> {
  static const _csvToList = CsvToListConverter();

  final T Function(Map<String, dynamic>) json;
  late List<String> _titles;
  final T? none;
  ToModelFrom({
    required this.json,
    List<String>? titles,
    this.none,
  }) {
    _titles = titles ?? [];
  }

  List<T> csvListFile(File file) {
    final csvList = _csvToList.convert(file.readAsStringSync());
    return csvListToModelList(csvList.sublist(1));
  }

  List<T> jsonListFile(File file) => fromJsonListString(file.readAsStringSync());
  T fromJsonFile(File file) => fromJsonString(file.readAsStringSync());

  List<T> fromJsonListString(String jsonString) =>
      convert.json.decode(jsonString).map((jsonMap) => json(jsonMap)).toList();

  T fromJsonString(String jsonString) => json(convert.json.decode(jsonString));

  T fromJson(Map<String, dynamic> jsonMap) => json(jsonMap);

  T csvToModel(List<dynamic> csv) {
    final jsonData = {for (var i = 0; i < _titles.length; i++) _titles[i]: csv[i] == '' ? null : csv[i]};
    return json(jsonData);
  }

  List<dynamic> jsonToCsv(Map<String, dynamic> json) {
    return _titles.map((key) => json[key]).toList();
  }

  List<T> csvListToModelList(List<List<dynamic>> csvList) {
    return csvList.map((csv) => csvToModel(csv)).toList();
  }

  List<T> jsonListToModelList(List<Map<String, dynamic>> jsonList) {
    return jsonList.map((jsonMap) => json(jsonMap)).toList();
  }
}
