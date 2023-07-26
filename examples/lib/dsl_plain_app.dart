import 'package:flutter/material.dart';
import 'package:wt_app_scaffold/app_platform.dart';

void main() async {
  await runMyApp(
    virtualSize: 800,
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
              )
        },
      ),
    ),
  );
}
