import 'package:flutter/material.dart';
import 'package:wt_app_definition/app_definition.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/scaffolds/app/affinity_app/affinity_app.dart';

enum ApplicationType with ApplicationBuilder {
  hiddenDrawer(HiddenDrawerApp.build),
  bottomNavBar(BottomNavBarApp.build),
  curvedNavBar(CurvedNavBarApp.build),
  goRouterMenu(GoRouterMenuApp.build),
  affinityApp(AffinityApp.build);

  @override
  final Widget Function(AppDefinition, bool) builder;

  const ApplicationType(this.builder);
}
