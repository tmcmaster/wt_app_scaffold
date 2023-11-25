import 'package:flutter/material.dart';
import 'package:wt_app_scaffold/models/app_styles.dart';
import 'package:wt_app_scaffold/scaffolds/app/go_router_menu_app/cross_fade_transition_builder.dart';

mixin SharedAppConfig {
  static final styles = AppStyles(
    theme: ThemeData(
      useMaterial3: true,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CrossFadeTransitionBuilder(),
          TargetPlatform.iOS: CrossFadeTransitionBuilder(),
          TargetPlatform.macOS: CrossFadeTransitionBuilder(),
        },
      ),
    ),
  );
}
