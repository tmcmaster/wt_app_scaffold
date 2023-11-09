import 'package:flutter/material.dart';

class AppStyles {
  final ThemeData theme;
  final ThemeData darkTheme;
  AppStyles({required this.theme, ThemeData? darkTheme})
      : darkTheme = darkTheme ??
            ThemeData.dark(useMaterial3: true).copyWith(
              textTheme: theme.textTheme,
              appBarTheme: theme.appBarTheme,
            );

  factory AppStyles.empty() => AppStyles(theme: ThemeData.light());
}
