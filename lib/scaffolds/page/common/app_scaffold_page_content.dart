import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AppScaffoldPageContent extends ConsumerStatefulWidget {
  final Widget body;
  final Widget? header;
  final Widget? drawer;
  final bool scrollable;
  final Widget Function(BuildContext)? footerBuilder;

  const AppScaffoldPageContent({
    super.key,
    this.header,
    required this.body,
    this.footerBuilder,
    this.drawer,
    this.scrollable = false,
  });

  @override
  ConsumerState<AppScaffoldPageContent> createState() => _AppScaffoldPageContentState();
}

class _AppScaffoldPageContentState extends ConsumerState<AppScaffoldPageContent> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        children: [
          if (widget.header != null) widget.header!,
          Expanded(
            child: widget.scrollable ? SingleChildScrollView(child: widget.body) : widget.body,
          ),
        ],
      ),
      drawer: Drawer(
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Settings',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
      // drawer: widget.drawer,
      bottomNavigationBar: widget.footerBuilder == null
          ? null
          : Builder(
              builder: (context) => widget.footerBuilder!.call(context),
            ),
    );
  }
}
