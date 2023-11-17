import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';
import 'package:wt_app_scaffold/models/app_styles.dart';
import 'package:wt_app_scaffold/scaffolds/app/go_router_menu_app/go_router_app.dart';
import 'package:wt_logging/wt_logging.dart';

mixin ScaffoldTestApp {
  static final details = Provider<AppDetails>(
    name: 'Scaffold Test App',
    (ref) => AppDetails(
      title: 'Scaffold Test App',
      subTitle: 'This is a sub-title',
      iconPath: 'assets/avocado.png',
    ),
  );

  static final definition = Provider<AppDefinition>(
    name: 'Scaffold Test App',
    (ref) => AppDefinition.from(
      appTitle: 'Scaffold Test App',
      appName: 'scaffoldTestApp',
      swipeEnabled: true,
      includeAppBar: true,
      appDetailsProvider: details,
      profilePage: null,
      applicationType: ApplicationType.goRouterMenu,
      pages: [
        PageDefinition(
          title: 'Landing Page',
          icon: FontAwesomeIcons.clipboard,
          primary: true,
          scaffoldType: ScaffoldType.transparentCard,
          builder: (context, _, __) => const LandingPage(),
          drawerBuilder: (context) => Container(),
        ),
        PageDefinition(
          title: 'Another Page',
          icon: FontAwesomeIcons.clipboard,
          primary: true,
          scaffoldType: ScaffoldType.transparentCard,
          builder: (context, _, __) => const TestWebView(),
        ),
      ],
    ),
  );

  static final styles = Provider<AppStyles>(
    name: 'Scaffold App Test Styles',
    (ref) => GoRouterMenuApp.styles,
  );
}

class TestWebView extends StatelessWidget {
  static final log = logger(TestWebView, level: Level.debug);

  const TestWebView({super.key});

  @override
  Widget build(BuildContext context) {
    return RestrictedWebViewMobile(
      url: 'https://google.com',
      backgroundColor: Colors.transparent,
      navigationPredicate: WebViewPredicates.notContainsPredicate([
        RegExp('m.youtube'),
      ]),
      onPageLoading: (url) {
        log.d('Loading page: $url');
      },
      onPageProgress: (progress) {
        log.d('Loading progress: $progress');
      },
      onPageLoaded: (url) {
        log.d('Page loaded: $url');
      },
      onPageLeave: (url) {
        log.d('Leaving page: $url');
      },
      onPageBlocked: (url) {
        log.d('Page blocked: $url');
      },
      onPageError: (error) {
        log.d('Loading page error: $error');
      },
    );
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final backgroundColor = colorScheme.secondary;
    final foregroundColor = colorScheme.onSecondary;

    return SliverPageScaffold(
      pinnedHeader: true,
      appBarColor: backgroundColor,
      collapsedHeight: 60,
      header: Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.menu,
                color: foregroundColor,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.menu,
                color: foregroundColor,
              ),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.blue,
                backgroundColor: Colors.white,
              ),
              onPressed: () {},
              child: const Text(
                'Test 3',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings,
                color: foregroundColor,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 300,
            width: 300,
            color: Colors.blue.withOpacity(0.5),
          ),
          Container(
            height: 300,
            width: 300,
            color: Colors.yellow.withOpacity(0.5),
          ),
          Container(
            height: 300,
            width: 300,
            color: Colors.orange.withOpacity(0.5),
          ),
        ],
      ),
      footer: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OutlinedButton(
              onPressed: () {},
              child: const Text('Test'),
            ),
            OutlinedButton(
              onPressed: () {},
              child: const Text('Test'),
            ),
          ],
        ),
      ),
    );
  }
}
