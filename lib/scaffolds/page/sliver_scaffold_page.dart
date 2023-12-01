import 'package:flutter/material.dart';

class SliverPageScaffold extends StatelessWidget {
  final Widget? banner;
  final Widget? header;
  final Widget? body;
  final Widget? footer;
  final bool pinnedHeader;
  final bool floatingBanner;
  final bool centerTitle;
  final bool stretchBanner;
  final double expandedHeight;
  final double? tooBarHeight;
  final double? collapsedHeight;
  final double stretchTriggerOffset;
  final Color appBarColor;
  final Widget? leading;
  final bool appBarBackButtonAllowed;
  const SliverPageScaffold({
    super.key,
    this.banner,
    this.header,
    this.body,
    this.footer,
    this.pinnedHeader = false,
    this.floatingBanner = false,
    this.centerTitle = true,
    this.stretchBanner = true,
    this.expandedHeight = 300,
    this.collapsedHeight,
    this.tooBarHeight,
    this.stretchTriggerOffset = 300.0,
    this.appBarColor = Colors.transparent,
    this.leading,
    this.appBarBackButtonAllowed = true,
  });

  bool get hasAppBar => banner != null || header != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            if (hasAppBar)
              SliverAppBar(
                leading:
                    leading ?? (appBarBackButtonAllowed ? null : Container()),
                backgroundColor: appBarColor,
                stretch: stretchBanner,
                floating: floatingBanner,
                pinned: pinnedHeader,
                stretchTriggerOffset: stretchTriggerOffset,
                expandedHeight: banner == null ? 0 : expandedHeight,
                collapsedHeight: collapsedHeight,
                toolbarHeight: tooBarHeight ?? kToolbarHeight,
                shape: const ContinuousRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: centerTitle,
                  title: header,
                  titlePadding: const EdgeInsets.only(bottom: 16),
                  background: Padding(
                    padding: const EdgeInsets.only(bottom: 50.0),
                    child: banner,
                  ),
                ),
              ),
            if (body != null)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: body,
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: footer == null
          ? null
          : Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
                left: 16,
                right: 16,
              ),
              child: OverflowBar(
                overflowAlignment: OverflowBarAlignment.center,
                alignment: MainAxisAlignment.center,
                children: <Widget>[footer!],
              ),
            ),
    );
  }
}
