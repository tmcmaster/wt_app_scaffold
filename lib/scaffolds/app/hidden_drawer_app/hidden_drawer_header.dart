import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/app_scaffolds_providers.dart';

class HiddenDrawerHeader extends ConsumerWidget {
  const HiddenDrawerHeader({
    Key? key,
    required this.onCloseDrawer,
  }) : super(key: key);

  final VoidCallback onCloseDrawer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appDetails = ref.watch(AppScaffoldProviders.appDetails);

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
      child: Row(
        children: [
          Material(
            color: Colors.transparent,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: onCloseDrawer,
            ),
          ),
          const SizedBox(width: 4),
          CircleAvatar(backgroundImage: AssetImage(appDetails.iconPath)),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appDetails.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(
                appDetails.subTitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
