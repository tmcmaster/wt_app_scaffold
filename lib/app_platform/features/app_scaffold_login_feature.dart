import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wt_app_scaffold/app_platform/auth/app_scaffold_authentication_store.dart';
import 'package:wt_app_scaffold/app_platform/model/app_scaffold_context_map.dart';
import 'package:wt_app_scaffold/app_platform/model/app_scaffold_feature_definition.dart';
import 'package:wt_app_scaffold/providers/go_router_store.dart';
import 'package:wt_app_scaffold/widgets/placeholder_page.dart';
import 'package:wt_logging/wt_logging.dart';

class AppScaffoldLoginFeature extends AppScaffoldFeatureDefinition {
  static final log = logger(AppScaffoldLoginFeature, level: Level.debug);

  final Widget? splashWidget;

  AppScaffoldLoginFeature(
    AppScaffoldFeatureDefinition childFeature, {
    this.splashWidget,
  }) : super(
          contextBuilder: (contextMap) {
            final AppScaffoldContextMap newContext = {
              ...contextMap,
            };
            return childFeature.contextBuilder(newContext);
          },
          widgetBuilder: (context, ref) {
            final authState = ref.watch(AppScaffoldAuthenticationStore.stream);
            final routes = ref.read(GoRouterStore.routes);
            final initialRoute = ref.read(GoRouterStore.initialRoute);
            log.d('Initial Route: $initialRoute');
            log.d('Routes: ${routes.map((e) => e.path).toList()}');
            return authState.when(
              data: (user) {
                if (user.authenticated) {
                  return childFeature.widgetBuilder(context, ref);
                } else {
                  log.d('===> AUTH DATA MaterialApp');
                  return MaterialApp.router(
                    title: 'Login Feature',
                    debugShowCheckedModeBanner: false,
                    routerConfig: GoRouter(
                      initialLocation: initialRoute,
                      routes: routes,
                    ),
                  );
                }
              },
              error: (error, stacktrace) {
                log.d('===> AUTH ERROR MaterialApp');
                return const MaterialApp(
                  title: 'Login Feature Error',
                  debugShowCheckedModeBanner: false,
                  home: PlaceholderPage(
                    title: 'An error occurred',
                  ),
                );
              },
              loading: () {
                log.d('===> AUTH LOADING MaterialApp');
                return const MaterialApp(
                  title: 'Login Feature Loading',
                  debugShowCheckedModeBanner: false,
                  home: Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(
                        color: Colors.green,
                      ),
                    ),
                  ),
                );
              },
            );
          },
          childFeature: childFeature,
        );
}
