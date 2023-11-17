import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:wt_logging/wt_logging.dart';

typedef OnPageLoading = void Function(String, int);

class RestrictedWebViewMobile extends StatefulWidget {
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
  const RestrictedWebViewMobile({
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
  State<RestrictedWebViewMobile> createState() =>
      _RestrictedWebViewMobileState();
}

class _RestrictedWebViewMobileState extends State<RestrictedWebViewMobile> {
  static final log = logger(RestrictedWebViewMobile, level: Level.debug);

  late WebViewController _controller;

  @override
  void initState() {
    super.initState();

    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: widget.allowsInlineMediaPlayback,
        mediaTypesRequiringUserAction: <PlaybackMediaTypes>{
          if (widget.allowsInlineMediaPlayback)
            ...widget.mediaTypesRequiringUserAction,
        },
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    // if (!kIsWeb) {
    controller
      ..setJavaScriptMode(widget.javascriptMode)
      ..setBackgroundColor(widget.backgroundColor)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            log.d('Page is loading (progress : $progress%)');
            widget.onPageProgress?.call(progress);
          },
          onPageStarted: (String url) {
            widget.onPageLoading?.call(url);
            log.d('Page started loading: $url');
          },
          onPageFinished: (String url) {
            widget.onPageLoading?.call(url);
            log.d('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            final errorMessage = '''
              Could not load page: 
              Page resource error: ${error.url}
                code: ${error.errorCode}
                description: ${error.description}
                errorType: ${error.errorType}
                isForMainFrame: ${error.isForMainFrame}
              '''
                .trimLeft()
                .trimRight()
                .replaceAll('            ', '');
            widget.onPageError?.call(errorMessage);
            debugPrint(errorMessage);
          },
          onNavigationRequest: (NavigationRequest request) {
            log.d('=====> onNavigationRequest: ${request.url}');
            if (widget.navigationPredicate?.call(request.url) ?? true) {
              log.d('=====> allowing navigation to ${request.url}');
              return NavigationDecision.navigate;
            }
            widget.onPageBlocked?.call(request.url);
            log.d('=====> blocking navigation to ${request.url}');
            return NavigationDecision.prevent;
          },
          onUrlChange: (UrlChange change) {
            log.d('url change to ${change.url}');
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(
        Uri.parse(widget.url),
        headers: widget.headers,
      );

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(false);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          scrollbars: false,
        ),
        child: WebViewWidget(
          controller: _controller,
        ),
      ),
    );
  }
}
