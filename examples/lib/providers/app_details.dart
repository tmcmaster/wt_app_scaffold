import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wt_app_scaffold/app_scaffolds.dart';

final appDetailsProvider = Provider<AppDetails>(
  (ref) => AppDetails(
    title: '',
    subTitle: 'Really long name, to test how the UI will react',
    iconPath: 'avocado.png',
  ),
);
