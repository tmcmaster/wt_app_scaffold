import 'package:flutter/material.dart';
import 'package:wt_app_scaffold/app_platform/scaffold_app_dsl.dart';

void main() async {
  await runMyApp(
    asPlainApp(
      MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => Scaffold(
                backgroundColor: Colors.orangeAccent,
                body: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/green');
                    },
                    child: const Text('To Green'),
                  ),
                ),
              ),
          '/green': (context) => Scaffold(
                backgroundColor: Colors.green,
                body: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/');
                    },
                    child: const Text('To Orange'),
                  ),
                ),
              ),
        },
      ),
    ),
    virtualSize: 800,
  );
}
