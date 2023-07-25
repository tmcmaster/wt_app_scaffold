import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FutureProviderScope extends ConsumerWidget {
  final Future<List<Override>> Function(WidgetRef ref) init;
  final Widget child;
  const FutureProviderScope({
    super.key,
    required this.init,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: init(ref),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ProviderScope(
            overrides: snapshot.data!,
            child: child,
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
