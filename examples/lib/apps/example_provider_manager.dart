import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_logging/wt_logging.dart';
import 'package:wt_provider_manager/wt_provider_manager.dart';

class ExampleProviderManager extends ProviderManager {
  static final log = logger(ExampleProviderManager, level: Level.debug);

  static final provider = Provider(
    name: 'ExampleProviderManager',
    (ref) {
      return ExampleProviderManager._(ref);
    },
  );

  ExampleProviderManager._(super.ref)
      : super(
          name: '',
        );
}
