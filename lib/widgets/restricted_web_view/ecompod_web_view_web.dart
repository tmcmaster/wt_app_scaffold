import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart' show JavaScriptMode;
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:webview_universal/webview_universal.dart';
import 'package:wt_logging/wt_logging.dart';

class RestrictedWebViewWeb extends StatefulWidget {
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

  const RestrictedWebViewWeb({
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
  State<RestrictedWebViewWeb> createState() => _RestrictedWebViewWebState();
}

class _RestrictedWebViewWebState extends State<RestrictedWebViewWeb> {
  static final log = logger(RestrictedWebViewWeb, level: Level.debug);

  WebViewController webViewController = WebViewController();

  @override
  void initState() {
    super.initState();
    final uri = Uri.parse(widget.url);
    log.d('URL(${widget.url}) : URI($uri)');
    webViewController.init(
      context: context,
      setState: setState,
      uri: Uri.parse(widget.url),
    );
  }

  @override
  Widget build(BuildContext context) {
    log.d('Building webview controller for cart: ${widget.url}');
    return WebView(
      controller: webViewController,
    );
  }
}
