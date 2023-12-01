import 'package:flutter/material.dart';
import 'package:wt_app_scaffold/app_platform/model/app_scaffold_feature_definition.dart';
import 'package:wt_logging/wt_logging.dart';

class AppScaffoldPlainAppFeature extends AppScaffoldFeatureDefinition {
  static final log = logger(AppScaffoldPlainAppFeature, level: Level.debug);

  AppScaffoldPlainAppFeature(Widget child)
      : super(
          contextBuilder: (contextMap) async {
            return contextMap;
          },
          widgetBuilder: (context, ref) {
            return child;
          },
        );
}
