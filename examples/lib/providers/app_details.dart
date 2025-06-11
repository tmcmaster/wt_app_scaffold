import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_definition/app_definition.dart';

final appDetailsProvider = Provider<AppDetails>(
  (ref) => AppDetails(
    name: 'myApp',
    title: 'My App',
    subTitle: '',
    iconPath: 'avocado.png',
  ),
);
