import 'package:wt_app_scaffold/models/drawer_builder.dart';
import 'package:wt_app_scaffold/models/item_definition.dart';
import 'package:wt_app_scaffold/models/page_builder.dart';
import 'package:wt_app_scaffold/models/scaffold_page_type.dart';

class PageDefinition extends ItemDefinition {
  final String? name;
  final bool landing;
  final AppScaffoldPageBuilder builder;
  final DrawerBuilder? drawerBuilder;
  final List<PageDefinition> childPages;
  final ScaffoldPageType? scaffoldType;
  final bool centerTitle;
  final bool showAppBar;
  final bool showBottomMenu;
  PageDefinition({
    this.name,
    required super.title,
    super.tabTitle,
    required super.icon,
    super.primary,
    super.debug,
    required this.builder,
    this.drawerBuilder,
    this.landing = false,
    this.childPages = const [],
    this.scaffoldType,
    this.centerTitle = true,
    this.showAppBar = false,
    this.showBottomMenu = false,
  });

  String get route => '/${name ?? title.replaceAll(' ', '_').toLowerCase()}';
}
