import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'job_state.dart';

class JobStateNotifier extends StateNotifier<JobState> {
  JobStateNotifier()
      : super(JobState(
          total: 0,
          completed: 0,
          currentItem: '',
        ));

  start({
    required int total,
    String currentItem = '',
  }) {
    state = JobState(total: total, completed: 0, currentItem: currentItem);
  }

  next({String? currentItem}) {
    if (state.completed + 1 <= state.total) {
      state = JobState(
        total: state.total,
        completed: state.completed + 1,
        currentItem: currentItem ?? '',
        errors: state.errors,
      );
    }
  }

  error(String message) {
    state = JobState(
      total: state.total,
      completed: state.completed + 1,
      currentItem: state.currentItem,
      errors: [...state.errors, '${state.currentItem} : $message'],
    );
  }

  finished() {
    state = JobState(
      total: state.total,
      completed: state.total,
      currentItem: '',
      errors: state.errors,
    );
  }
}
