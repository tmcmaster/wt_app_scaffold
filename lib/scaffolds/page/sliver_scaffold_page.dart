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
  final double stretchTriggerOffset;

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
    this.stretchTriggerOffset = 300.0,
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
                backgroundColor: Colors.transparent,
                stretch: stretchBanner,
                floating: floatingBanner,
                pinned: pinnedHeader,
                stretchTriggerOffset: stretchTriggerOffset,
                expandedHeight: banner == null ? 0 : expandedHeight,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: centerTitle,
                  title: header,
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
