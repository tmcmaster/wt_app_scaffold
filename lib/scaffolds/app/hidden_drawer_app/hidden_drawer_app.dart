import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/providers/app_scaffolds_providers.dart';
import 'package:wt_app_scaffold/scaffolds/app/hidden_drawer_app/hidden_drawer_config.dart';
import 'package:wt_app_scaffold/scaffolds/app/hidden_drawer_app/hidden_drawer_widget.dart';
import 'package:wt_app_scaffold/scaffolds/app/hidden_drawer_app/hidden_page_builder.dart';
import 'package:wt_app_scaffold/scaffolds/app/shared_app_config.dart';
import 'package:wt_logging/wt_logging.dart';

class HiddenDrawerApp extends ConsumerStatefulWidget {
  static final styles = SharedAppConfig.styles.copyWith(
    theme: SharedAppConfig.styles.theme.copyWith(),
  );

  static final page =
      StateNotifierProvider<HiddenDrawPageController, PageDefinition>(
    name: 'HiddenDrawerApp.router',
    (ref) => HiddenDrawPageController(ref),
  );

  static final router = page.notifier;

  final AppDefinition appDefinition;
  final bool debugMode;
  final double offsetWhenOpenX;
  final double offsetWhenOpenY;

  const HiddenDrawerApp._({
    required this.appDefinition,
    this.debugMode = false,
    required this.offsetWhenOpenX,
    required this.offsetWhenOpenY,
  });

  factory HiddenDrawerApp.build(
    AppDefinition appDefinition,
    bool debugMode,
  ) {
    final maxLength = appDefinition.pages
        .map((p) => p.title.split(' '))
        .expand((e) => e)
        .map((e) => e.length)
        .fold(0, (largest, size) => size > largest ? size : largest);
    return HiddenDrawerApp._(
      appDefinition: appDefinition,
      debugMode: debugMode,
      offsetWhenOpenX:
          140.0 + HiddenDrawerConfig.menuFontSize * 0.55 * maxLength,
      offsetWhenOpenY: 150.0,
    );
  }

  @override
  ConsumerState<HiddenDrawerApp> createState() => _HiddenDrawerAppState();
}

class _HiddenDrawerAppState extends ConsumerState<HiddenDrawerApp> {
  static final log = logger(HiddenDrawerApp, level: Level.debug);

  late double xOffset;
  late double yOffset;
  late double scaleFactor;
  late bool isDrawerOpen;

  PageDefinition? page;
  bool isDragging = false;

  @override
  void initState() {
    super.initState();

    closeDrawer();
  }

  void closeDrawer() {
    setState(() {
      xOffset = 0;
      yOffset = 0;
      scaleFactor = 1;
      isDrawerOpen = false;
    });
  }

  void openDrawer() {
    setState(() {
      xOffset = widget.offsetWhenOpenX;
      yOffset = widget.offsetWhenOpenY;
      scaleFactor = 0.6;
      isDrawerOpen = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final newPage = ref.watch(HiddenDrawerApp.page);
    final seedColor = widget.appDefinition.colorScheme == null
        ? ref.watch(ApplicationSettings.colorScheme.value)
        : widget.appDefinition.colorScheme!;
    log.d('Seed Color: $seedColor');
    final debugMode = ref.watch(ApplicationSettings.debugMode.value);
    final appStyles = ref.read(AppScaffoldProviders.appStyles);

    return MaterialApp(
      theme: appStyles.theme.copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: seedColor),
      ),
      debugShowCheckedModeBanner: debugMode,
      navigatorKey: ref.read(UserLog.navigatorKey),
      scaffoldMessengerKey: ref.read(UserLog.snackBarKey),
      home: Scaffold(
        backgroundColor: HSLColor.fromColor(colorScheme.primary)
            .withLightness(0.1)
            .toColor(),
        body: Stack(
          children: [
            buildDrawer(context),
            buildPage(newPage),
            // buildPage(page ?? widget.appDefinition.pages.first),
          ],
        ),
      ),
    );
  }

  Widget buildDrawer(BuildContext context) {
    return SafeArea(
      child: HiddenDrawerWidget(
        appDefinition: widget.appDefinition,
        debugMode: widget.debugMode,
        width: xOffset,
        onCloseDrawer: closeDrawer,
        onSelectedItem: (page) {
          ref.read(HiddenDrawerApp.router).go(page.route);
          // setState(() => this.page = page);
          closeDrawer();
        },
      ),
    );
  }

  Widget buildPage(PageDefinition page) {
    return PopScope(
      canPop: isDrawerOpen,
      onPopInvoked: (didPop) {
        if (didPop) {
          closeDrawer();
        }
      },
      child: GestureDetector(
        onTap: isDrawerOpen ? closeDrawer : null,
        onHorizontalDragStart: widget.appDefinition.swipeEnabled
            ? (details) => isDragging = true
            : null,
        onHorizontalDragUpdate: widget.appDefinition.swipeEnabled
            ? (details) {
                if (!isDragging) return;
                const delta = 1;
                if (details.delta.dx > delta) {
                  openDrawer();
                } else if (details.delta.dx < -delta) {
                  closeDrawer();
                }
                isDragging = false;
              }
            : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          transform: Matrix4.translationValues(xOffset, yOffset, 0)
            ..scale(scaleFactor),
          child: AbsorbPointer(
            absorbing: isDrawerOpen,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(isDrawerOpen ? 20 : 0),
              child: ColoredBox(
                color: isDrawerOpen
                    ? Colors.white12
                    : Theme.of(context).primaryColor,
                child: HiddenDrawerOpener(
                  open: openDrawer,
                  child: HiddenPageBuilder(
                    includeAppBar: widget.appDefinition.includeAppBar,
                    menuAction: widget.appDefinition.menuAction,
                    pageDefinition: page,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HiddenDrawPageController extends StateNotifier<PageDefinition> {
  static late Map<String, PageDefinition> _pageIndex;

  HiddenDrawPageController(Ref ref)
      : super(ref.read(AppScaffoldProviders.appDefinition).pages.first) {
    _pageIndex = {
      for (final page in ref.read(AppScaffoldProviders.appDefinition).pages)
        page.route: page,
    };
  }

  void go(String path) {
    final newPage = _pageIndex[path];
    if (newPage != null) {
      state = newPage;
    }
  }
}
