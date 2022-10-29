// @deprecated
// abstract class JsonSupport<T> {
//   Map<String, dynamic> toJson();
//   //T fromJson(Map<String, dynamic> item);
//   String getId();
//
//   @override
//   bool operator ==(dynamic other) => (other is T && (other as JsonSupport).getId() == getId());
//
//   @override
//   int get hashCode => getId().hashCode;
// }

// import 'package:utils/models/models.dart';
//
// @deprecated
// abstract class BaseModel<T extends JsonSupport> {
//   static T csvToModel<T>(List<dynamic> csv, List<String> titles, T Function(Map<String, dynamic>) converter) {
//     final jsonData = {for (var i = 0; i < titles.length; i++) titles[i]: csv[i] == '' ? null : csv[i]};
//     return converter(jsonData);
//   }
//
//   static List<dynamic> jsonToCsv(Map<String, dynamic> json, List<String> titles) {
//     return titles.map((key) => json[key]).toList();
//   }
//
//   static List<T> csvListToModelList<T>(
//       List<List<dynamic>> csvList, List<String> titles, T Function(Map<String, dynamic>) converter) {
//     return csvList.map((csv) => csvToModel(csv, titles, converter)).toList();
//   }
//
//   static List<List<dynamic>> jsonListToCsvList(List<Map<String, dynamic>> jsonList, List<String> titles) {
//     final csvList = jsonList.map((json) => jsonToCsv(json, titles)).toList();
//     return [
//       titles,
//       ...csvList,
//     ];
//   }
//
//   static List<dynamic> modelToCsv(JsonSupport model, List<String> titles) {
//     final json = modelToJson(model);
//     return titles.map((title) => json[title]).toList();
//   }
//
//   static Map<String, dynamic> modelToJson(JsonSupport model) {
//     return model.toJson();
//   }
//
//   static List<Map<String, dynamic>> modelListToJsonList(List<JsonSupport> models) {
//     return models.map((model) => model.toJson()).toList();
//   }
//
//   static List<List<dynamic>> modelListToCsvList(List<JsonSupport> models, List<String> titles) {
//     final csvList = models.map((model) => jsonToCsv(model.toJson(), titles)).toList();
//     return [
//       titles,
//       ...csvList,
//     ];
//   }
//
//   static List<T> jsonListToModelList<T>(
//       List<Map<String, dynamic>> jsonList, T Function(Map<String, dynamic> json) converter) {
//     return jsonList.map((json) => converter(json)).toList();
//   }
//
//   // TODO: Investigate generics methods for JSON encode and decode
//   // static Map<String, dynamic> modelToJson<T extends JsonSupport>(T item) => item.toJson();
//   // static T jsonToModel<T extends JsonSupport>(Map<String, dynamic> json) => json.decode(json);
//
// }
