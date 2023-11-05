import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersion extends StatefulWidget {
  const AppVersion({super.key});

  @override
  State<AppVersion> createState() => _AppVersionState();
}

class _AppVersionState extends State<AppVersion> {
  String version = '';
  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((value) {
      setState(() {
        version = 'v${value.version}+${value.buildNumber}';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final versionStyle = textTheme.titleMedium?.copyWith(
      color: Colors.grey.shade600,
    );
    return version.isNotEmpty
        ? Text(
            'Version: $version',
            style: versionStyle,
          )
        : Text(
            'Version not available',
            style: versionStyle,
          );
  }
}
