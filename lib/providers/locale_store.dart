import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocaleStore extends StateNotifier<Locale?> {
  static final locales = Provider<List<Locale>>(
    (ref) => throw Exception('LocaleStore.locales needs to be overridden.'),
  );

  static final provider = StateNotifierProvider<LocaleStore, Locale?>(
    name: 'Locale',
    (ref) => LocaleStore._(),
  );

  LocaleStore._() : super(null);

  void setLocale(Locale locale) {
    if (state != locale) {
      state = locale;
    }
  }
}
