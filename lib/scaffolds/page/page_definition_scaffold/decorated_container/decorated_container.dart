import 'package:flutter/material.dart';
import 'package:wt_app_scaffold/scaffolds/page/page_definition_scaffold/decorated_container/transparent_card.dart';

class DecoratedContainer extends StatelessWidget {
  final Widget child;
  final double childMaxWidth;
  final EdgeInsets padding;
  final CustomPainter painter;

  const DecoratedContainer({
    super.key,
    required this.child,
    this.childMaxWidth = 1200,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    required this.painter,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      final height = constraints.maxHeight;
      final aspect = width / height;

      final availableWidth = width - padding.left - padding.right;
      final availableHeight = height - padding.top - padding.bottom;

      final childTop = padding.top;
      final childHeight = availableHeight;
      final childWidth = availableWidth < childMaxWidth * 1.05 ? availableWidth * 0.9 : childMaxWidth;
      final childLeft = padding.left + (availableWidth - childWidth) / 2;

      return Column(
        children: [
          Expanded(
            child: Stack(
              clipBehavior: Clip.hardEdge,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: AspectRatio(
                    aspectRatio: _constrainAspectRation(aspect) * 3,
                    child: SizedBox(
                      width: double.infinity,
                      child: CustomPaint(
                        painter: painter,
                        child: Container(),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: childTop,
                  left: childLeft,
                  width: childWidth,
                  height: childHeight,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    child: Scaffold(
                      backgroundColor: Colors.transparent,
                      body: TransparentCard(
                        child: child,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  double _constrainAspectRation(
    double aspect, {
    double min = 0.25,
    double max = 2.5,
  }) {
    return (aspect < min
        ? min
        : aspect > max
            ? max
            : aspect);
  }
}
