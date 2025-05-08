import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wt_app_scaffold/models/app_scaffold_typedefs.dart';
import 'package:wt_app_scaffold/scaffolds/page/common/app_scaffold_page_controls.dart';

class AppScaffoldPageDrawer extends StatelessWidget {
  final AppScaffoldSettingsMapProviders settingsProviders;

  const AppScaffoldPageDrawer({
    super.key,
    required this.settingsProviders,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 400,
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(
            Icons.settings,
            color: Colors.black,
          ),
          title: const Text(
            'Settings',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: false,
          actions: [
            IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(
                Icons.close,
                color: Colors.black,
              ),
            )
          ],
        ),
        body: AppScaffoldPageControls(
          settingsProviders: settingsProviders,
        ),
      ),
    );
  }
}
