import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_platform/model/app_scaffold_feature_definition.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_logging/wt_logging.dart';

// global application settings like error handling, monitoring and logging levels
class AppScaffoldPlatformFeature extends AppScaffoldFeatureDefinition {
  static final log = logger(AppScaffoldPlatformFeature, level: Level.debug);

  AppScaffoldPlatformFeature(
    AppScaffoldFeatureDefinition childFeature, {
    required bool devicePreview,
    void Function(BuildContext, WidgetRef)? onReady,
    double? virtualSize,
    required bool enableErrorMonitoring,
    required Level setApplicationLogLevel,
  }) : super(
          contextBuilder: (contextMap) {
            log.i('Setting the log level to: $setApplicationLogLevel');
            Logger.level = setApplicationLogLevel;

            log.i('Logging level has been set to $setApplicationLogLevel');

            if (enableErrorMonitoring) {
              log.i('Enabling error monitoring');
              FlutterError.onError = (FlutterErrorDetails details) {
                log.e(
                  '=================== CAUGHT FLUTTER ERROR ===================',
                );
                log.e('Exception: ${details.exception}');
                log.e('Stack: ${details.stack}');
                log.e('Library: ${details.library}');
                log.e(
                  '============================================================',
                );
              };
            }
            final newContext = {
              ...contextMap,
            };
            return childFeature.contextBuilder(newContext);
          },
          widgetBuilder: (context, ref) {
            log.d('Application has been configured and is ready to be built');
            if (onReady != null) {
              log.d('Running onReady function.');
              try {
                onReady.call(context, ref);
              } catch (error) {
                rethrow;
              }
            }
            return _DevicePreviewWrapper(
              virtualSize: virtualSize,
              devicePreview: devicePreview,
              child: childFeature.widgetBuilder(context, ref),
            );
          },
          childFeature: childFeature,
        );
}

class _DevicePreviewWrapper extends StatelessWidget {
  final Widget child;
  final bool devicePreview;
  final double? virtualSize;
  const _DevicePreviewWrapper({
    required this.devicePreview,
    required this.virtualSize,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return devicePreview
        ? LayoutBuilder(
            builder: (context, constraints) {
              return constraints.maxWidth > 500
                  ? DevicePreview(
                      isToolbarVisible: false,
                      builder: (_) => SafeArea(
                        child: _VirtualSizeWrapper(
                          virtualSize: virtualSize,
                          child: child,
                        ),
                      ),
                    )
                  : _VirtualSizeWrapper(
                      virtualSize: virtualSize,
                      child: child,
                    );
            },
          )
        : _VirtualSizeWrapper(
            virtualSize: virtualSize,
            child: child,
          );
  }
}

class _VirtualSizeWrapper extends StatelessWidget {
  final Widget child;
  final double? virtualSize;
  const _VirtualSizeWrapper({
    required this.virtualSize,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return virtualSize == null
        ? child
        : VirtualSizeFittedBox(
            virtualSize: virtualSize!,
            child: child,
          );
  }
}
