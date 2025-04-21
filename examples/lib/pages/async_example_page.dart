import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_logging/wt_logging.dart';

class AsyncExamplePage extends ConsumerWidget {
  static final log = logger(AsyncExamplePage);

  const AsyncExamplePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              FutureBuilder(
                future: ref.watch(futureCombined.future),
                builder: (_, snapshot) {
                  if (snapshot.hasError) {
                    return Text('ERROR: ${snapshot.error}');
                  } else {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return const Text('NONE');
                      case ConnectionState.waiting:
                        return const CircularProgressIndicator();
                      case ConnectionState.active:
                        return Text('${snapshot.data}');
                      case ConnectionState.done:
                        return Text('${snapshot.data}');
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final futureCombined = FutureProvider<String>((ref) {
  AsyncExamplePage.log.d('Future Combined.');
  return WaitFor.threeFutures(
    ref.read(futureOne.future),
    ref.read(futureTwo.future),
    ref.read(futureThree.future),
    (v1, v2, v3) => '$v1 : $v2 : $v3',
  );
});

final futureOne = FutureProvider<String>((ref) async {
  AsyncExamplePage.log.d('Future One started.');
  await Future.delayed(const Duration(seconds: 10));
  AsyncExamplePage.log.d('Future One completed.');
  return 'Future One';
});

final futureTwo = FutureProvider<String>((ref) async {
  AsyncExamplePage.log.d('Future Two started.');
  await Future.delayed(const Duration(seconds: 14));
  AsyncExamplePage.log.d('Future Two completed.');
  return 'Future Two';
});

final futureThree = FutureProvider<String>((ref) async {
  AsyncExamplePage.log.d('Future Three started.');
  await Future.delayed(const Duration(seconds: 8));
  AsyncExamplePage.log.d('Future Three completed.');
  return 'Future Three';
});

final counterProvider = StreamProvider<int>((ref) => counting());

Stream<int> counting() async* {
  for (int i = 1; i <= 30; i++) {
    await Future.delayed(const Duration(seconds: 1));
    yield i;
  }
}
