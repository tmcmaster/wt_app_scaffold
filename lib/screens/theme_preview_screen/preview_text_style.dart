import 'package:flutter/material.dart';
import 'package:wt_app_scaffold/scaffolds/page/page_definition_scaffold/transparent_card.dart';

class PreviewTextStyles extends StatelessWidget {
  const PreviewTextStyles({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final textStyles = {
      'Label Small': theme.labelSmall,
      'Label Medium': theme.labelMedium,
      'Label Large': theme.labelLarge,
      'Body Small': theme.bodySmall,
      'Body Medium': theme.bodyMedium,
      'Body Large': theme.bodyLarge,
      'Title Small': theme.titleSmall,
      'Title Medium': theme.titleMedium,
      'Title Large': theme.titleLarge,
      'Headline Small': theme.headlineSmall,
      'Headline Medium': theme.headlineMedium,
      'Headline large': theme.headlineLarge,
      'Display Small': theme.displaySmall,
      'Display Medium': theme.displayMedium,
      'Display Large': theme.displayLarge,
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: textStyles.entries
          .map(
            (s) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: TransparentCard(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    s.key,
                    style: s.value,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
