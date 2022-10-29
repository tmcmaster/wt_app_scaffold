import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'job_state_providers.dart';

export 'dependencies_notifier.dart';
export 'dependency_checker.dart';
export 'job_state.dart';
export 'job_state_notifier.dart';
export 'job_state_providers.dart';

class JobStateButton extends HookConsumerWidget {
  final VoidCallback? onPressed;
  final Icon icon;
  final bool startStop;
  final JobStateProviders jobState;
  final String? label;
  final Color color;
  final bool floating;
  const JobStateButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.startStop = false,
    required this.jobState,
    this.label,
    this.color = Colors.white,
    this.floating = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(jobState.progress);
    final bool dependencies = ref.watch(jobState.dependencies);
    final notifier = ref.read(jobState.progress.notifier);
    final colorScheme = Theme.of(context).colorScheme;

    final action = progress.done && onPressed != null && dependencies
        ? () {
            try {
              if (startStop) notifier.finished();
              onPressed!.call();
            } catch (error) {
              // TODO: need to review what to doo with error
              rethrow;
            } finally {
              if (startStop) notifier.start(total: 1);
            }
          }
        : null;
    return label != null
        ? ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 4,
              backgroundColor: colorScheme.primary,
            ),
            onPressed: action,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  size: 15,
                  icon.icon,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  label ?? '',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          )
        : floating
            ? FloatingActionButton(
                child: Icon(icon.icon),
                enableFeedback: true,
                backgroundColor: colorScheme.primary,
                foregroundColor: action == null ? Colors.blueAccent.shade700 : Colors.white,
                onPressed: action,
              )
            : IconButton(
                color: colorScheme.onPrimary,
                icon: icon,
                enableFeedback: true,
                onPressed: action,
              );
  }
}
