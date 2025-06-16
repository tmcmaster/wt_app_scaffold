import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/scaffolds/app/go_router_menu_app/route_state.dart';

class RouteStateStore extends StateNotifier<RouteState> {
  static final provider = StateNotifierProvider<RouteStateStore, RouteState>(
    name: 'RouteStateStore.provider',
    (_) => RouteStateStore._(),
  );

  RouteStateStore._() : super(RouteState.initial());

  void setCurrentRoute(String route, int tab) => state = RouteState(route: route, tab: tab);
}
