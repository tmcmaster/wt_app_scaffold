import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_platform/config/cross_fade_transition_builder.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/models/app_sizing.dart';
import 'package:wt_app_scaffold/models/app_spacing.dart';
import 'package:wt_app_scaffold/models/app_styles.dart';

mixin SharedAppConfig {
  static AppStyles styles(Ref ref) {
    final settingsColor = ref.watch(ApplicationSettings.colorScheme.value);
    final colorScheme = ColorScheme.fromSeed(seedColor: settingsColor);

    return AppStyles(
      theme: ThemeData(
        colorScheme: colorScheme,
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          foregroundColor: colorScheme.onPrimary,
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CrossFadeTransitionBuilder(),
            TargetPlatform.iOS: CrossFadeTransitionBuilder(),
            TargetPlatform.macOS: CrossFadeTransitionBuilder(),
          },
        ),
        tabBarTheme: const TabBarTheme(
          labelPadding: EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 16.0,
          ),
        ),
        extensions: const [
          AppSizing(),
          AppSpacing(),
        ],
      ),
      darkTheme: ThemeData.dark(),
    );
  }
}
