import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wt_action_button/utils/logging.dart';

class ProviderMonitor with ChangeNotifier implements ProviderObserver {
  static final instance = ProviderMonitor._();
  // static final provider = ChangeNotifierProvider((ref) => instance);

  static final log = logger(ProviderMonitor);

  final families = <String, int>{};
  final values = <String, Object?>{};
  final updates = <String, int>{};
  final errors = <String, int>{};

  ProviderMonitor._();

  @override
  void didAddProvider(ProviderBase provider, Object? value, ProviderContainer container) {
    log.d('ProviderDebugger : didAddProvider : ${provider.name ?? provider.runtimeType.toString()}');
    if (provider.name != null) {
      log.d('Provider type: ${provider.runtimeType}');
      if (provider.name!.endsWith('family')) {
        families[provider.name!] = (families[provider.name!] ?? 0) + 1;
      } else {
        if (values.containsKey(provider.name)) {
          log.w('There was already a provider with name when it was added: ${provider.name}, Value($value))');
        } else {
          values[provider.name!] = value;
          notifyListeners();
        }
      }
    } else {
      log.w('Provider did not have a name: ${provider.runtimeType.toString()}');
    }
  }

  @override
  void didDisposeProvider(ProviderBase provider, ProviderContainer containers) {
    log.d('ProviderDebugger : didDisposeProvider : ${provider.name ?? provider.runtimeType.toString()}');
    if (provider.name != null) {
      if (provider.name!.endsWith('family')) {
        families[provider.name!] = (families[provider.name!] ?? 0) - 1;
      } else {
        if (values.containsKey(provider.name)) {
          values.remove(provider.name!);
          notifyListeners();
        } else {
          log.w('Provider was not in the provider list when it was disposed: ${provider.name}');
        }
      }
    } else {
      log.w('Provider did not have a name: ${provider.runtimeType.toString()}');
    }
  }

  @override
  void didUpdateProvider(ProviderBase provider, Object? previousValue, Object? newValue, ProviderContainer container) {
    log.v('ProviderDebugger : didUpdateProvider : ${provider.name}');
    if (provider.name != null) {
      updates[provider.name!] = (updates[provider.name!] ?? 0) + 1;
      values[provider.name!] = newValue;
      notifyListeners();
    } else {
      log.w('Provider did not have a name: ${provider.runtimeType.toString()}');
    }
  }

  @override
  void providerDidFail(ProviderBase provider, Object error, StackTrace stackTrace, ProviderContainer container) {
    log.w('ProviderDebugger : providerDidFail : ${provider.name}: ${error.toString()}');
    if (provider.name != null) {
      errors[provider.name!] = (errors[provider.name!] ?? 0) + 1;
      notifyListeners();
    } else {
      log.w('Provider did not have a name: ${provider.runtimeType.toString()}');
    }
  }

  @override
  String toString() {
    return {
      // 'Provider List': _providerList,
      'Update Count': updates,
      // 'Error Count': _errorCount,
    }.toString();
  }
}
