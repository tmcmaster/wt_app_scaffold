import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_platform/auth/app_scaffold_authentication_interface.dart';
import 'package:wt_app_scaffold/app_platform/auth/app_scaffold_authentication_notifier.dart';
import 'package:wt_app_scaffold/app_platform/auth/app_scaffold_user.dart';
import 'package:wt_logging/wt_logging.dart';

mixin AppScaffoldAuthenticationStore {
  static final log = logger(AppScaffoldAuthenticationStore, level: Level.debug);
  static final user = StateNotifierProvider<AppScaffoldAuthenticationInterface,
      AppScaffoldUser>(
    name: 'ScaffoldAuthenticationStore.notifier',
    (ref) => AppScaffoldAuthenticationNotifier(),
  );

  static final stream = StreamProvider<AppScaffoldUser>(
    name: 'ScaffoldAuthenticationStore.stream',
    (ref) {
      log.d(
        'Setting up AppScaffoldAuthenticationStore.stream controller',
      );
      final controller = StreamController<AppScaffoldUser>();
      final subscription = ref.listen(user, (previous, next) {
        log.d('User auth status has changed: $next');
        controller.add(next);
      });
      Future.delayed(const Duration(seconds: 2), () {
        controller.add(
          ref.read(user),
        );
      });

      ref.onDispose(() {
        subscription.close();
        controller.close();
      });

      return controller.stream;
    },
  );
}
