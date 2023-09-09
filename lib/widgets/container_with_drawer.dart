import 'package:flutter/material.dart';

class ContainerWithDrawer extends StatefulWidget {
  final Widget mainPanel;
  final Widget drawerPanel;
  final Widget? openGapPanel;
  final Color? dragBarColor;
  final Color? dragBarNotchColor;
  final double openGap;
  final double handleThickness;
  final bool disableDrawScrolling;

  const ContainerWithDrawer({
    super.key,
    required this.mainPanel,
    required this.drawerPanel,
    this.openGapPanel,
    this.dragBarColor,
    this.dragBarNotchColor,
    this.openGap = 10,
    this.handleThickness = 20,
    this.disableDrawScrolling = false,
  });

  @override
  _ContainerWithDrawerState createState() => _ContainerWithDrawerState();
}

class _ContainerWithDrawerState extends State<ContainerWithDrawer> {
  double _drawerHeight = -1;

  @override
  Widget build(BuildContext context) {
    final dragBarColor =
        widget.dragBarColor ?? Theme.of(context).colorScheme.onPrimary;
    final dragBarNotchColor =
        widget.dragBarNotchColor ?? Theme.of(context).colorScheme.onPrimary;
    final minHeight = widget.openGap + widget.handleThickness;

    if (_drawerHeight < 0) {
      _drawerHeight = minHeight;
    }

    return Scaffold(
      body: widget.mainPanel,
      bottomSheet: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        height: _drawerHeight,
        child: GestureDetector(
          child: ColoredBox(
            color: Colors.white,
            child: Column(
              children: [
                GestureDetector(
                  onVerticalDragUpdate: (details) {
                    setState(() {
                      _drawerHeight -= details.delta.dy;
                      if (_drawerHeight < minHeight) {
                        _drawerHeight = minHeight;
                      }
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    height: widget.handleThickness,
                    color: dragBarColor,
                    child: Center(
                      child: Container(
                        width: 30,
                        height: 4,
                        color: dragBarNotchColor,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: widget.openGapPanel == null
                      ? widget.disableDrawScrolling
                          ? widget.drawerPanel
                          : SingleChildScrollView(
                              child: widget.drawerPanel,
                            )
                      : Column(
                          children: [
                            SizedBox(
                              height: widget.openGap,
                              child: widget.openGapPanel,
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: widget.drawerPanel,
                              ),
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
