import 'dart:ui';

import 'package:flutter/material.dart';

class AppSizing extends ThemeExtension<AppSizing> {
  static AppSizing of(BuildContext context) =>
      Theme.of(context).extension<AppSizing>() ?? const AppSizing();

  final double mini;
  final double small;
  final double medium;
  final double large;
  final double huge;

  const AppSizing({
    this.mini = 20,
    this.small = 50,
    this.medium = 100,
    this.large = 200,
    this.huge = 500,
  });

  @override
  ThemeExtension<AppSizing> lerp(
      covariant ThemeExtension<AppSizing>? other, double t) {
    if (other is! AppSizing) {
      return this;
    }

    return AppSizing(
      mini: lerpDouble(mini, other.mini, t) ?? mini,
      small: lerpDouble(small, other.small, t) ?? small,
      medium: lerpDouble(medium, other.medium, t) ?? medium,
      large: lerpDouble(large, other.large, t) ?? large,
      huge: lerpDouble(huge, other.huge, t) ?? huge,
    );
  }

  @override
  ThemeExtension<AppSizing> copyWith({
    double? mini,
    double? small,
    double? medium,
    double? large,
    double? huge,
  }) {
    return AppSizing(
      mini: mini ?? this.mini,
      small: small ?? this.small,
      medium: medium ?? this.medium,
      large: large ?? this.large,
      huge: huge ?? this.huge,
    );
  }
}
