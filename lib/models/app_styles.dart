import 'package:flutter/material.dart';
import 'package:wt_app_scaffold/models/app_sizing.dart';
import 'package:wt_app_scaffold/models/app_spacing.dart';

class AppStyles {
  final ThemeData theme;
  final ThemeData darkTheme;
  final AppSpacing spacing;
  final AppSizing sizing;

  AppStyles({
    ThemeData? theme,
    ThemeData? darkTheme,
    AppSpacing? spacing,
    AppSizing? sizing,
  })  : theme = theme?.copyWith(useMaterial3: true) ??
            ThemeData.light(useMaterial3: true),
        darkTheme = darkTheme?.copyWith(useMaterial3: true) ??
            ThemeData.dark(useMaterial3: true),
        spacing = spacing ?? const AppSpacing(),
        sizing = sizing ?? const AppSizing();

  AppStyles copyWith({
    ThemeData? theme,
    ThemeData? darkTheme,
    AppSpacing? spacing,
    AppSizing? sizing,
  }) {
    return AppStyles(
      theme: theme ?? this.theme,
      darkTheme: darkTheme ?? this.darkTheme,
      spacing: spacing ?? this.spacing,
      sizing: sizing ?? this.sizing,
    );
  }
}
