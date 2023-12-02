import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_platform/util/app_scaffold_router.dart';
import 'package:wt_logging/wt_logging.dart';

class AppScaffoldMaterialAppRouter implements AppScaffoldRouter {
  static final router = Provider<AppScaffoldMaterialAppRouter>(
    name: 'NavigatorRouter.provider',
    (ref) => AppScaffoldMaterialAppRouter(ref),
  );
  final Ref ref;
  AppScaffoldMaterialAppRouter(this.ref);

  @override
  void go(String path, {Object? extra}) {
    ref.read(UserLogStore.navigatorKey).currentState?.pushNamed(path);
  }
}
