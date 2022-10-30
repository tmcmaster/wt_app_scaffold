import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/scaffolds/app/hidden_drawer_app/logout_action.dart';

import '../../../models/item_definition.dart';
import 'hidden_drawer_header.dart';

class HiddenDrawerWidget extends ConsumerWidget {
  static const double menuPaddingX = 16;

  final AppDefinition appDefinition;
  final bool debugMode;
  final ValueChanged<PageDefinition> onSelectedItem;
  final VoidCallback onCloseDrawer;
  final double width;

  const HiddenDrawerWidget({
    Key? key,
    required this.appDefinition,
    this.debugMode = false,
    required this.onSelectedItem,
    required this.onCloseDrawer,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logoutAction = ref.read(LogoutAction.provider);

    return Container(
      padding: const EdgeInsets.fromLTRB(menuPaddingX, 32, menuPaddingX, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HiddenDrawerHeader(
            onCloseDrawer: onCloseDrawer,
          ),
          const SizedBox(height: 12),
          Expanded(
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: SizedBox(
                        width: width < 50 ? width : width - (menuPaddingX * 2),
                        child: buildDrawerItems(context),
                      ),
                    ),
                  ),
                  buildDrawerActions(logoutAction),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildDrawerActions(ActionButtonDefinition logoutAction) => Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _PageMenuItemButton(
              item: appDefinition.profilePage,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
              ),
              onTap: () => onSelectedItem(appDefinition.profilePage),
            ),
            ListTile(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 0,
              ),
              leading: const Icon(Icons.logout, color: Colors.white),
              title: const Text(
                'Logout',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              onTap: () {},
            )
          ].map((w) => SizedBox(width: 170, height: 50, child: w)).toList(),
        ),
      );

  Widget buildDrawerItems(BuildContext context) {
    return Column(
        children: appDefinition.pages
            .where((page) {
              return debugMode || !page.debug;
            })
            .map(
              (page) => _PageMenuItemButton(
                item: page,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 8,
                ),
                onTap: () => onSelectedItem(page),
              ),
            )
            .toList());
  }
}

class _PageMenuItemButton extends StatelessWidget {
  final ItemDefinition item;
  final GestureTapCallback? onTap;
  final BorderRadius borderRadius;
  final EdgeInsets padding;
  const _PageMenuItemButton({
    Key? key,
    required this.item,
    required this.borderRadius,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 24,
      vertical: 0,
    ),
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
      contentPadding: padding,
      leading: Icon(item.icon, color: Colors.white),
      title: Text(
        item.title,
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
      onTap: onTap,
    );
  }
}
