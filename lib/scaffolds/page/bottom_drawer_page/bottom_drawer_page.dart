import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:wt_action_button/action_button_definition.dart';

class BottomDrawerPage extends StatelessWidget {
  final String title;
  final Widget mainWidget;
  final Widget drawWidget;
  final ActionButtonDefinition action;
  final List<ActionButtonDefinition> actions;
  final bool includeAppBar;

  const BottomDrawerPage({
    super.key,
    required this.title,
    required this.mainWidget,
    required this.drawWidget,
    required this.action,
    required this.actions,
    this.includeAppBar = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Scaffold(
        appBar: includeAppBar
            ? AppBar(
                title: Text(title),
                centerTitle: true,
                backgroundColor: colorScheme.primary,
                leading: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: action.component(noLabel: true),
                    ),
                  ],
                ),
                actions: [
                  ...actions.map((action) => action.component(noLabel: true)),
                  const SizedBox(width: 10),
                ],
              )
            : null,
        body: DraggableBottomSheet(
          minExtent: 70,
          // expansionExtent: 20,
          collapsed: true,
          useSafeArea: false,
          curve: Curves.easeIn,
          previewWidget: Column(
            children: [
              const _DrawerHandleWidget(),
              Container(
                height: 30,
                color: Colors.white,
                width: double.infinity,
              ),
            ],
          ),
          expandedWidget: Container(
            width: double.infinity,
            color: Colors.white,
            child: Column(
              children: [
                const _DrawerHandleWidget(),
                Container(
                  height: 30,
                  color: Colors.white,
                  width: double.infinity,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: drawWidget,
                    ),
                  ),
                ),
              ],
            ),
          ),
          backgroundWidget: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.grey.shade50,
            child: Column(
              children: [
                Expanded(child: mainWidget),
                const SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
          duration: const Duration(milliseconds: 10),
          maxExtent: MediaQuery.of(context).size.height * 0.8,
          onDragging: (_) {},
        ),
        floatingActionButton: includeAppBar
            ? null
            : action.component(
                floating: true,
                noLabel: true,
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: includeAppBar
            ? null
            : SizedBox(
                height: 50,
                child: BottomAppBar(
                  color: colorScheme.primary,
                  shape: const CircularNotchedRectangle(),
                  notchMargin: 5,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ...actions
                          .map((action) => action.component(noLabel: true)),
                      const SizedBox(
                        width: 50,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  // Widget _buildActionButton(Color primary, BuildContext context) {
  //   return action.jobState != null
  //       ? JobStateButton(
  //           icon: Icon(action.icon),
  //           color: Colors.white,
  //           startStop: true,
  //           floating: false,
  //           jobState: action.jobState!,
  //           onPressed: () => action.onTap(context),
  //         )
  //       : IconButton(
  //           onPressed: () => action.onTap(context),
  //           icon: Icon(action.icon),
  //         );
  // }

  // Widget _buildFloatingActionButton(Color primary, BuildContext context) {
  //   return action.jobState != null
  //       ? JobStateButton(
  //           icon: Icon(action.icon),
  //           color: primary,
  //           startStop: true,
  //           floating: true,
  //           jobState: action.jobState!,
  //           onPressed: () => action.onTap(context),
  //         )
  //       : FloatingActionButton(
  //           onPressed: () => action.onTap(context),
  //           backgroundColor: primary,
  //           enableFeedback: true,
  //           child: Icon(action.icon),
  //         );
  // }
}

class _DrawerHandleWidget extends StatelessWidget {
  const _DrawerHandleWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 35,
      color: Colors.grey.shade300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 5,
            color: Colors.grey.shade700,
          ),
        ],
      ),
    );
  }
}
