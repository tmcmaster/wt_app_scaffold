import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wt_app_scaffold/providers/locale_store.dart';

class LocaleSelector extends ConsumerWidget {
  const LocaleSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locales = ref.read(LocaleStore.locales);
    final notifier = ref.read(LocaleStore.provider.notifier);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: locales
          .map(
            (locale) => LocaleButton(
              locale: locale,
              onPressed: () {
                notifier.setLocale(locale);
              },
            ),
          )
          .toList(),
    );
  }
}

class LocaleButton extends ConsumerWidget {
  final Locale locale;
  final void Function() onPressed;

  const LocaleButton({
    super.key,
    required this.locale,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageName = 'assets/locales/${locale.languageCode}.svg';
    final selectedLocale = ref.watch(LocaleStore.provider);
    return Container(
      decoration: locale == selectedLocale
          ? BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade500,
              ),
            )
          : null,
      padding: const EdgeInsets.all(2),
      child: IconButton(
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        splashRadius: 10,
        onPressed: onPressed,
        icon: SvgPicture.asset(
          width: 30,
          imageName,
        ),
      ),
    );
  }
}
