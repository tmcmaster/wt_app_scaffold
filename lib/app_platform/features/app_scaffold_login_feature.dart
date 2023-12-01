import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wt_app_scaffold/app_platform/auth/app_scaffold_authentication.dart';
import 'package:wt_app_scaffold/app_platform/model/app_scaffold_context_map.dart';
import 'package:wt_app_scaffold/app_platform/model/app_scaffold_feature_definition.dart';
import 'package:wt_app_scaffold/providers/go_router_store.dart';
import 'package:wt_app_scaffold/widgets/placeholder_page.dart';
import 'package:wt_logging/wt_logging.dart';

class AppScaffoldLoginFeature extends AppScaffoldFeatureDefinition {
  static final log = logger(AppScaffoldLoginFeature, level: Level.debug);

  AppScaffoldLoginFeature(AppScaffoldFeatureDefinition childFeature)
      : super(
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
                  return MaterialApp.router(
                    routerConfig: GoRouter(
                      initialLocation: initialRoute,
                      routes: routes,
                    ),
                  );
                }
              },
              error: (error, stacktrace) => const MaterialApp(
                home: PlaceholderPage(
                  title: 'An error occurred',
                ),
              ),
              loading: () => const MaterialApp(
                home: Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            );
          },
          childFeature: childFeature,
        );
}
