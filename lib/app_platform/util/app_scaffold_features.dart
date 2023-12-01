import 'package:flutter/material.dart';
import 'package:wt_app_scaffold/app_platform/features/app_scaffold_application_feature.dart';
import 'package:wt_app_scaffold/app_platform/features/app_scaffold_login_feature.dart';
import 'package:wt_app_scaffold/app_platform/features/app_scaffold_platform_feature.dart';
import 'package:wt_app_scaffold/app_platform/model/app_scaffold_feature_definition.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';

mixin AppScaffoldFeatures {
  static bool isApplicationFeatureAvailable() {
    return AppScaffoldFeatureDefinition.isFeatureAvailable(
      AppScaffoldApplicationFeature,
    );
  }

  static bool isLoginFeatureAvailable() {
    return AppScaffoldFeatureDefinition.isFeatureAvailable(
      AppScaffoldLoginFeature,
    );
  }

  static bool isPlatformFeatureAvailable() {
    return AppScaffoldFeatureDefinition.isFeatureAvailable(
      AppScaffoldPlatformFeature,
    );
  }

  static bool isGoRouterMenuApp(BuildContext context) {
    return _isAvailable<GoRouterMenuApp>(context);
  }

  static bool isCurvedNavBarApp(BuildContext context) {
    return _isAvailable<CurvedNavBarApp>(context);
  }

  static bool _isAvailable<T extends Widget>(BuildContext context) {
    return context.findAncestorWidgetOfExactType<T>() != null;
  }
}
