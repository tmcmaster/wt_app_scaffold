import 'package:flutter/material.dart';
import 'package:wt_app_scaffold/app_platform/widget/app_scaffold_material_app.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/scaffolds/app/hidden_drawer_app/hidden_drawer_stack.dart';

class HiddenDrawerApp extends StatelessWidget {
  final AppDefinition appDefinition;
  final bool debugMode;

  const HiddenDrawerApp._({
    required this.appDefinition,
    this.debugMode = false,
  });

  factory HiddenDrawerApp.build(
    AppDefinition appDefinition,
    bool debugMode,
  ) {
    return HiddenDrawerApp._(
      appDefinition: appDefinition,
      debugMode: debugMode,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffoldMaterialApp.fromWidget(
      HiddenDrawStack(
        appDefinition: appDefinition,
        debugMode: debugMode,
      ),
    );
  }
}
