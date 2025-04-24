import 'package:flutter/material.dart';
import 'package:wt_logging/wt_logging.dart';

class PlaceholderPage extends StatelessWidget {
  static final log = logger(PlaceholderPage);

  static const routeName = 'settings';

  final String title;
  final bool includeAppBar;
  final void Function(BuildContext context)? dismissAction;
  final void Function(BuildContext context)? menuAction;
  final Widget? bottomNavigationBar;
  final WidgetBuilder? drawerBuilder;
  final Color? backgroundColor;
  final List<Widget> children;
  const PlaceholderPage({
    super.key,
    required this.title,
    this.includeAppBar = false,
    this.dismissAction,
    this.menuAction,
    this.bottomNavigationBar,
    this.drawerBuilder,
    this.backgroundColor,
    this.children = const [],
  });

  factory PlaceholderPage.transparent({
    required String title,
  }) =>
      PlaceholderPage(
        title: title,
        backgroundColor: Colors.transparent,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: includeAppBar
          ? AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              elevation: 0,
              leading: dismissAction == null && menuAction == null ? null : _createIconButton(context),
              title: Text(title),
            )
          : null,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 60,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Text(
              'Work in Progress',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                color: Theme.of(context).primaryColor,
              ),
            ),
            ...children,
          ],
        ),
      ),
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: drawerBuilder == null
          ? null
          : SizedBox.square(
              dimension: 32,
              child: FloatingActionButton(
                onPressed: () {
                  debugPrint('Page: $title');
                  _showBottomDrawer(context);
                },
                child: const Icon(Icons.settings),
              ),
            ),
      // drawer: drawerBuilder?.call(context),
    );
  }

  IconButton? _createIconButton(BuildContext context) {
    return menuAction == null && dismissAction == null
        ? null
        : IconButton(
            icon: Icon(menuAction != null ? Icons.menu : Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              menuAction?.call(context);
              log.d('${menuAction == null}');
              //menuAction ?? dismissAction,
            },
          );
  }

  // TODO: need to review using this
  void _showBottomDrawer(BuildContext context) {
    final widget = drawerBuilder!.call(context);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.25,
          maxChildSize: 0.95,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 16.0,
                    ),
                    child: widget,
                  ),
                ),
              ),
              // child: ListView(
              //   controller: scrollController,
              //   children: [
              //     const SizedBox(height: 12),
              //     Center(
              //       child: Container(
              //         width: 40,
              //         height: 5,
              //         decoration: BoxDecoration(
              //           color: Colors.grey[300],
              //           borderRadius: BorderRadius.circular(10),
              //         ),
              //       ),
              //     ),
              //     if (drawerBuilder != null)
              //       Padding(
              //         padding: const EdgeInsets.all(16.0),
              //         child: Expanded(child: widget),
              //       ),
              //   ],
              // ),
            );
          },
        );
      },
    );
  }
}
