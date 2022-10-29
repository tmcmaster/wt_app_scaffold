import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HiddenDrawerOpener extends InheritedWidget {
  final VoidCallback open;

  HiddenDrawerOpener({
    required super.child,
    required this.open,
  });

  static HiddenDrawerOpener? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<HiddenDrawerOpener>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
