import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';

class CurvedNavBarApp extends StatefulWidget {
  final AppDefinition appDefinition;
  final bool debugMode;
  const CurvedNavBarApp._({
    required this.appDefinition,
    required this.debugMode,
  });

  factory CurvedNavBarApp.build(
    AppDefinition appDefinition,
    bool debugMode,
  ) {
    return CurvedNavBarApp._(
      appDefinition: appDefinition,
      debugMode: debugMode,
    );
  }
  @override
  _CurvedNavBarAppState createState() => _CurvedNavBarAppState();
}

class _CurvedNavBarAppState extends State<CurvedNavBarApp> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();

  int index = 0;

  @override
  Widget build(BuildContext context) {
    final screens = widget.appDefinition.pages
        .where((page) {
          return widget.debugMode || !page.debug;
        })
        .map(
          (page) => page.builder(context),
        )
        .toList();

    final items = widget.appDefinition.pages
        .where((page) {
          return widget.debugMode || !page.debug;
        })
        .map((definition) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                definition.icon,
                size: 20,
              ),
            ))
        .toList();

    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      color: colorScheme.primary,
      child: SafeArea(
        top: false,
        child: ClipRect(
          child: Scaffold(
            extendBody: true,
            backgroundColor: colorScheme.onPrimary,
            // appBar: AppBar(
            //   title: const Text('Curved Navigation Bar'),
            //   elevation: 0,
            //   centerTitle: true,
            //   backgroundColor: colorScheme.primary,
            // ),
            body: screens[index],
            bottomNavigationBar: Theme(
              data: Theme.of(context).copyWith(
                iconTheme: IconThemeData(
                  color: colorScheme.onPrimary,
                ),
              ),
              child: CurvedNavigationBar(
                key: navigationKey,
                color: colorScheme.primary,
                buttonBackgroundColor: colorScheme.primary,
                backgroundColor: Colors.transparent,
                height: 50,
                animationCurve: Curves.easeInOut,
                animationDuration: const Duration(milliseconds: 500),
                index: index,
                items: items,
                onTap: (index) => setState(() => this.index = index),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
