import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_definition/app_definition.dart';
import 'package:wt_logging/wt_logging.dart';

class AffinityAppRouter implements AppDefinitionRouter {
  static final router = Provider<AffinityAppRouter>(
    name: 'NavigatorRouter.provider',
    (ref) => AffinityAppRouter(ref),
  );
  final Ref ref;
  AffinityAppRouter(this.ref);

  @override
  void go(String path, {Object? extra}) {
    // TODO: need to review if this should be a push replace
    ref.read(UserLogStore.navigatorKey).currentState?.pushNamed(path);
  }

  @override
  void push(String path, {Object? extra}) {
    ref.read(UserLogStore.navigatorKey).currentState?.pushNamed(path);
  }
}
