import 'package:wt_app_scaffold/app_platform/model/app_scaffold_context_builder.dart';
import 'package:wt_app_scaffold/app_platform/model/app_scaffold_widget_builder.dart';

abstract class AppScaffoldFeatureDefinition {
  static final _features = <Type, bool>{};
  final AppScaffoldContextBuilder contextBuilder;
  final AppScaffoldWidgetBuilder widgetBuilder;
  final AppScaffoldFeatureDefinition? childFeature;

  AppScaffoldFeatureDefinition({
    required this.contextBuilder,
    required this.widgetBuilder,
    this.childFeature,
  }) {
    _features[runtimeType] = true;
  }

  static bool isFeatureAvailable(Type featureType) {
    return _features.containsKey(featureType);
  }
}
