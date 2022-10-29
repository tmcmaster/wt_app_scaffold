import 'package:flutter/material.dart';
import 'package:job_state_button/job_state_button.dart';

import 'item_definition.dart';

class ActionDefinition extends ItemDefinition {
  final void Function(BuildContext context) onTap;
  final JobStateProviders? jobState;

  ActionDefinition({
    required super.title,
    required super.icon,
    required this.onTap,
    this.jobState,
  });
}
