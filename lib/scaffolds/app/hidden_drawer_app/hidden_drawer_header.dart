import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_app_scaffold/app_platform/providers/app_platform_providers.dart';

class HiddenDrawerHeader extends ConsumerWidget {
  const HiddenDrawerHeader({
    super.key,
    required this.onCloseDrawer,
  });

  final VoidCallback onCloseDrawer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appDetails = ref.watch(AppPlatformProviders.appDetails);

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
          Container(
            height: 32,
            width: 32,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Image.asset(appDetails.iconPath),
          ),
          // CircleAvatar(
          //   backgroundImage: AssetImage(appDetails.iconPath),
          //   backgroundColor: Colors.white,
          // ),
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
          ),
        ],
      ),
    );
  }
}
