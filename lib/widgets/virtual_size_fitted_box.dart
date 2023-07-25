import 'package:flutter/material.dart';

class VirtualSizeFittedBox extends StatelessWidget {
  final double virtualSize;
  final Widget child;

  const VirtualSizeFittedBox({
    super.key,
    required this.virtualSize,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxSize = constraints.maxWidth > constraints.maxHeight
            ? constraints.maxWidth
            : constraints.maxHeight;
        final ratio = virtualSize / maxSize;

        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: FittedBox(
            child: Container(
              width: constraints.maxWidth * ratio,
              height: constraints.maxHeight * ratio,
              color: Colors.amber,
              child: child,
            ),
          ),
        );
      },
    );
  }
}
