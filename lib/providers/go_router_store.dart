import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wt_app_definition/app_definition.dart';
import 'package:wt_app_scaffold/app_platform/auth/app_scaffold_authentication_store.dart';

mixin GoRouterStore {
  static final initialRoute = Provider<String>(
    name: 'AuthProviders.initialRoute',
    (ref) => '/',
  );

  static final routes = Provider<List<GoRoute>>(
    name: 'AuthProviders.loginRoutes',
    (ref) => [
      GoRoute(
        path: '/',
        builder: (context, state) => PlaceholderPage(
          title: 'Login Page',
          children: [
            ElevatedButton(
              onPressed: () {
                ref.read(AppScaffoldAuthenticationStore.user.notifier).signInWithEmail('', '');
              },
              child: const Text('Sign In'),
            ),
          ],
        ),
      ),
    ],
  );
}
