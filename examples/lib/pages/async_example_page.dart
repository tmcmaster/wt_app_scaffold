import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wt_firepod/wt_firepod.dart';

class AsyncExamplePage extends ConsumerWidget {
  const AsyncExamplePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Counter(ref),
              const SizedBox(
                height: 200,
              ),
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
                        return const Text('WAITING');
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

class Counter extends ConsumerWidget {
  final WidgetRef ref;

  Counter(this.ref, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.read(counterProvider.stream);
    return StreamBuilder(
      stream: counter,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('ERROR: ${snapshot.error}');
        } else if (snapshot.connectionState == ConnectionState.done) {
          return const Text('DONE');
        } else {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Text('NONE');
            case ConnectionState.waiting:
              return const Text('WAITING');
            case ConnectionState.done:
              return const Text('DONE');
            case ConnectionState.active:
              return Text('${snapshot.data}');
          }
        }
      },
    );
  }
}

final futureCombined = FutureProvider<String>((ref) async {
  print('Future Combined.');
  return WaitFor.threeFutures(
    ref.read(futureOne.future),
    ref.read(futureTwo.future),
    ref.read(futureThree.future),
    (v1, v2, v3) => '$v1 : $v2 : $v3',
  );
});

final futureOne = FutureProvider<String>((ref) async {
  print('Future One started.');
  await Future.delayed(const Duration(seconds: 10));
  print('Future One completed.');
  return 'Future One';
});

final futureTwo = FutureProvider<String>((ref) async {
  print('Future Two started.');
  await Future.delayed(const Duration(seconds: 14));
  print('Future Two completed.');
  return 'Future Two';
});

final futureThree = FutureProvider<String>((ref) async {
  print('Future Three started.');
  await Future.delayed(const Duration(seconds: 8));
  print('Future Three completed.');
  return 'Future Three';
});

final counterProvider = StreamProvider<int>((ref) => counting());

Stream<int> counting() async* {
  for (int i = 1; i <= 30; i++) {
    await Future.delayed(const Duration(seconds: 1));
    yield i;
  }
}
