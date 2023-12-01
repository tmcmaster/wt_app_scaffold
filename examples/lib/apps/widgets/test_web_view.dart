import 'package:flutter/material.dart';
import 'package:wt_app_scaffold/widgets/restricted_web_view/restricted_web_view_predicates.dart';
import 'package:wt_app_scaffold/widgets/restricted_web_view/restricted_webview_mobile.dart';
import 'package:wt_logging/wt_logging.dart';

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
