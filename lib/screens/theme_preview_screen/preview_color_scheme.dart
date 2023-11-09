import 'package:flutter/material.dart';

class ColorPair {
  final Color background;
  final Color foreground;

  ColorPair(this.background, this.foreground);
}

class PreviewColorScheme extends StatelessWidget {
  const PreviewColorScheme({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final colors = <String, ColorPair>{
      'Primary': ColorPair(
        colorScheme.primary,
        colorScheme.onPrimary,
      ),
      'Primary Container': ColorPair(
        colorScheme.primaryContainer,
        colorScheme.onPrimaryContainer,
      ),
      'Secondary': ColorPair(
        colorScheme.secondary,
        colorScheme.onSecondary,
      ),
      'Secondary Container': ColorPair(
        colorScheme.secondaryContainer,
        colorScheme.onSecondaryContainer,
      ),
      'Tertiary': ColorPair(
        colorScheme.tertiary,
        colorScheme.onTertiary,
      ),
      'Tertiary Container': ColorPair(
        colorScheme.tertiaryContainer,
        colorScheme.onTertiaryContainer,
      ),
      'Background': ColorPair(
        colorScheme.background,
        colorScheme.onBackground,
      ),
      'Surface': ColorPair(
        colorScheme.surface,
        colorScheme.onSurface,
      ),
      'Surface Variant': ColorPair(
        colorScheme.surfaceVariant,
        colorScheme.onSurfaceVariant,
      ),
      'InverseSurface': ColorPair(
        colorScheme.inverseSurface,
        colorScheme.onInverseSurface,
      ),
      'Error': ColorPair(
        colorScheme.error,
        colorScheme.onError,
      ),
      'Error Container': ColorPair(
        colorScheme.errorContainer,
        colorScheme.onErrorContainer,
      ),
    };
    final otherColors = {
      'Outline': colorScheme.outline,
      'Outline Variant': colorScheme.outlineVariant,
      'Inverse Primary': colorScheme.inversePrimary,
      'Surface Tint': colorScheme.surfaceTint,
      'Scrim': colorScheme.scrim,
      'Shadow': colorScheme.shadow,
    };
    return Center(
      child: Column(
        children: [
          ...colors.entries.map(
            (color) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Container(
                width: double.infinity,
                height: 50,
                color: color.value.background,
                child: Center(
                  child: Text(
                    color.key,
                    style: TextStyle(
                      color: color.value.foreground,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: otherColors.entries
                .map(
                  (color) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          color.key,
                          textAlign: TextAlign.end,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          color: color.value,
                        ),
                      ].toList(),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
