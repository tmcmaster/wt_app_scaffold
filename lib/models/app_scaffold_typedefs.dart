import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_action_button/action_button_definition.dart';
import 'package:wt_settings/wt_settings.dart';

typedef AppScaffoldActionProviders = List<ProviderBase<ActionButtonDefinition>>;
typedef AppScaffoldSettingsProviders = List<BaseSettingsProviders<StateNotifier, dynamic>>;
typedef AppScaffoldSettingsMapProviders = Map<String, AppScaffoldSettingsProviders>;
