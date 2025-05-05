import 'package:flutter/widgets.dart';

class PageInfo {
  final String title;
  final String tabTitle;
  final String name;
  final IconData icon;

  const PageInfo({
    required this.title,
    required this.name,
    required this.icon,
    String? tabTitle,
  }) : tabTitle = tabTitle ?? title;

  String get route => '/$name';

  PageInfo copyWith({
    String? title,
    String? tabTitle,
    String? name,
    IconData? icon,
    PageInfo? pageInfo,
  }) {
    return PageInfo(
      title: title ?? pageInfo?.title ?? this.title,
      name: name ?? pageInfo?.name ?? this.name,
      icon: icon ?? pageInfo?.icon ?? this.icon,
      tabTitle: tabTitle ?? pageInfo?.tabTitle ?? this.tabTitle,
    );
  }
}
