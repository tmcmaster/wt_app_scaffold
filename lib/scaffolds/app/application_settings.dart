import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_settings/wt_settings.dart';

mixin ApplicationSettings {
  static void init(Ref ref) {
    ref.read(applicationType.value);
    ref.read(theme.value);
    ref.read(colorScheme.value);
    ref.read(debugMode.value);
  }

  static final theme = SettingsEnumProviders<ThemeMode>(
    key: '__THEME__',
    values: ThemeMode.values,
    none: ThemeMode.light,
    label: 'Theme Mode',
    hint: 'Define the color theme for the app..',
  );
  static final colorScheme = SettingsColorProviders(
    key: '__COLOR_SCHEME__',
    values: Colors.primaries,
    initialValue: Colors.blue,
    none: Colors.blue,
    label: 'Color Scheme',
    hint: 'Define the colour scheme for the app..',
  );

  static final debugMode = SettingsBoolProviders(
    key: '__DEBUG_MODE__',
    label: 'Debug Mode',
    hint: 'Enable debug mode.',
  );

  static final applicationType = SettingsEnumProviders(
    key: '__APPLICATION_TYPE__',
    label: 'Application Type',
    hint: 'Select the type of application structure',
    values: ApplicationType.values,
    none: ApplicationType.hiddenDrawer,
  );

  static final verifyEmail = SettingsBoolProviders(
    key: '__VERIFY_EMAIL__',
    label: 'Verify Email',
    hint: 'Should emails be required to be verified.',
    initialValue: false,
  );
}
