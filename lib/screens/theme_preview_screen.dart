import 'package:flutter/material.dart';
import 'package:wt_app_scaffold/screens/theme_preview_screen/preview_button_style.dart';
import 'package:wt_app_scaffold/screens/theme_preview_screen/preview_color_scheme.dart';
import 'package:wt_app_scaffold/screens/theme_preview_screen/preview_text_style.dart';

class ThemePreviewScreen extends StatefulWidget {
  const ThemePreviewScreen({super.key});

  @override
  State<ThemePreviewScreen> createState() => _ThemePreviewScreenState();
}

class _ThemePreviewScreenState extends State<ThemePreviewScreen>
    with TickerProviderStateMixin {
  final pages = <String, WidgetBuilder>{
    'Topography': (context) => const PreviewTextStyles(),
    'Buttons': (context) => const PreviewButtonStyles(),
    'Colors': (context) => const PreviewColorScheme(),
  };
  int index = 0;
  late TabController controller;

  @override
  void initState() {
    controller = TabController(
      length: pages.length,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TabBar(
            controller: controller,
            tabs: pages.keys.map((title) => Text(title)).toList(),
            isScrollable: true,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: TabBarView(
                controller: controller,
                children: pages.values
                    .map((builder) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            child: builder.call(context),
                          ),
                        ))
                    .toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
