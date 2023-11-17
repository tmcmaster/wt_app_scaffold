import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:wt_app_scaffold/widgets/restricted_web_view/ecompod_web_view_web.dart';
import 'package:wt_app_scaffold/widgets/restricted_web_view/restricted_webview_mobile.dart';
import 'package:wt_logging/wt_logging.dart';

class RestrictedWebView extends StatelessWidget {
  static final log = logger(RestrictedWebView, level: Level.debug);
  final String url;
  final Map<String, String> headers;
  final bool Function(String)? navigationPredicate;
  final bool allowsInlineMediaPlayback;
  final Set<PlaybackMediaTypes> mediaTypesRequiringUserAction;
  final JavaScriptMode javascriptMode;
  final Color backgroundColor;
  final ValueChanged<String>? onPageLoading;
  final ValueChanged<int>? onPageProgress;
  final ValueChanged<String>? onPageLoaded;
  final ValueChanged<String>? onPageLeave;
  final ValueChanged<String>? onPageBlocked;
  final ValueChanged<String>? onPageError;
  const RestrictedWebView({
    super.key,
    required this.url,
    this.headers = const <String, String>{},
    this.navigationPredicate,
    this.allowsInlineMediaPlayback = false,
    this.mediaTypesRequiringUserAction = const {},
    this.javascriptMode = JavaScriptMode.unrestricted,
    this.backgroundColor = Colors.white,
    this.onPageLoading,
    this.onPageProgress,
    this.onPageLoaded,
    this.onPageLeave,
    this.onPageBlocked,
    this.onPageError,
  });

  @override
  Widget build(BuildContext context) {
    log.d('Loading cart: $url');
    return kIsWeb
        ? RestrictedWebViewWeb(
            url: url,
            headers: headers,
          )
        : RestrictedWebViewMobile(
            url: url,
            headers: headers,
            backgroundColor: backgroundColor,
            navigationPredicate: navigationPredicate,
            onPageBlocked: onPageBlocked,
            onPageLoading: onPageLoading,
            onPageError: onPageError,
            onPageLeave: onPageLeave,
            onPageLoaded: onPageLoaded,
            onPageProgress: onPageProgress,
          );
  }
}
