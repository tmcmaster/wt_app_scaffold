import 'dart:ui';

import 'package:flutter/material.dart';

class AppSpacing extends ThemeExtension<AppSpacing> {
  static AppSpacing of(BuildContext context) =>
      Theme.of(context).extension<AppSpacing>() ?? const AppSpacing();

  final double mini;
  final double small;
  final double medium;
  final double large;
  final double huge;

  const AppSpacing({
    this.mini = 4,
    this.small = 8,
    this.medium = 16,
    this.large = 32,
    this.huge = 64,
  });

  @override
  ThemeExtension<AppSpacing> lerp(
      covariant ThemeExtension<AppSpacing>? other, double t) {
    if (other is! AppSpacing) {
      return this;
    }

    return AppSpacing(
      mini: lerpDouble(mini, other.mini, t) ?? mini,
      small: lerpDouble(small, other.small, t) ?? small,
      medium: lerpDouble(medium, other.medium, t) ?? medium,
      large: lerpDouble(large, other.large, t) ?? large,
      huge: lerpDouble(huge, other.huge, t) ?? huge,
    );
  }

  @override
  ThemeExtension<AppSpacing> copyWith({
    double? mini,
    double? small,
    double? medium,
    double? large,
    double? huge,
  }) {
    return AppSpacing(
      mini: mini ?? this.mini,
      small: small ?? this.small,
      medium: medium ?? this.medium,
      large: large ?? this.large,
      huge: huge ?? this.huge,
    );
  }
}
