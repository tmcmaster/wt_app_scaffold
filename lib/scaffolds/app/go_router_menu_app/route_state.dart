class RouteState {
  final String route;
  final int tab;

  RouteState({required this.route, required this.tab});

  factory RouteState.initial() => RouteState(route: '/', tab: 0);

  @override
  String toString() => 'RouteState(route: $route, tab: $tab)';
}
