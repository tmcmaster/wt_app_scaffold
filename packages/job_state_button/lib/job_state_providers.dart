import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'job_state.dart';
import 'job_state_notifier.dart';

class JobStateProviders {
  final StateNotifierProvider<JobStateNotifier, JobState> progress;
  final StateNotifierProvider<StateNotifier<bool>, bool> dependencies;

  JobStateProviders({
    required this.progress,
    required this.dependencies,
  });
}
