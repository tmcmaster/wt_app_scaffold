import 'package:flutter/cupertino.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';

mixin AppScaffoldFeatures {
  static bool firebaseIsAvailable(BuildContext context) {
    return _isAvailable<FirebaseSupport>(context);
  }

  static bool isGoRouterMenuApp(BuildContext context) {
    return _isAvailable<GoRouterMenuApp>(context);
  }

  static bool isCurvedNavBarApp(BuildContext context) {
    return _isAvailable<CurvedNavBarApp>(context);
  }

  static bool loginIsAvailable(BuildContext context) {
    return _isAvailable<LoginScreenSupport>(context);
  }

  static bool appScaffoldAvailable(BuildContext context) {
    return _isAvailable<AppScaffoldSupport>(context);
  }

  static bool _isAvailable<T extends Widget>(BuildContext context) {
    return context.findAncestorWidgetOfExactType<T>() != null;
  }
}
