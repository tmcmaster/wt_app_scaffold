import 'package:flutter/material.dart';

class TransparentCard extends StatelessWidget {
  static const bool outline = false;

  final Widget child;

  const TransparentCard({required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 12,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: outline
          ? Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.transparent,
                border: Border.all(
                  width: 1,
                  color: Colors.grey.shade500,
                ),
              ),
              child: child,
            )
          : child,
    );
  }
}
