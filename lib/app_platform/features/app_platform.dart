import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_platform/models/provider_override_definition.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/init/provider_monitor.dart';
import 'package:wt_app_scaffold/widgets/virtual_size_fitted_box.dart';
import 'package:wt_logging/wt_logging.dart';

class AppPlatform extends ConsumerWidget {
  static final log = logger(AppPlatform);

  final Widget child;
  final double? virtualSize;
  final List<ProviderObserver> includeObservers;
  final List<Override> includeOverrides;
  final bool enableProviderMonitoring;
  final bool enableErrorMonitoring;
  final Level setApplicationLogLevel;

  const AppPlatform({
    super.key,
    required this.child,
    this.virtualSize,
    this.enableProviderMonitoring = false,
    this.enableErrorMonitoring = false,
    this.includeObservers = const [],
    this.includeOverrides = const [],
    this.setApplicationLogLevel = Level.warning,
  });

  static Future<Map<ProviderListenable, ProviderOverrideDefinition>> init() async {
    return {
      UserLog.snackBarKey: ProviderOverrideDefinition(
        value: AppContainer.snackBarKey,
        override: UserLog.snackBarKey.overrideWithValue(AppContainer.snackBarKey),
      ),
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Logger.level = setApplicationLogLevel;

    if (enableErrorMonitoring) {
      FlutterError.onError = (FlutterErrorDetails details) {
        log.e('=================== CAUGHT FLUTTER ERROR ===================');
        log.e(details);
        log.e('============================================================');
      };
    }

    final providerScope = ProviderScope(
      overrides: [
        ...includeOverrides,
        UserLog.snackBarKey.overrideWithValue(AppContainer.snackBarKey),
      ],
      observers: [
        ...includeObservers,
        if (enableProviderMonitoring) ProviderMonitor.instance,
      ],
      child: virtualSize == null
          ? child
          : VirtualSizeFittedBox(
              virtualSize: virtualSize!,
              child: child,
            ),
    );

    return providerScope;
  }
}
