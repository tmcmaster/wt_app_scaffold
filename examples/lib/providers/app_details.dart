import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';

final appDetailsProvider = Provider<AppDetails>(
  (ref) => AppDetails(
    title: 'My App',
    subTitle: '',
    iconPath: 'avocado.png',
  ),
);
