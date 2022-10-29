import 'package:firepod/firepod_providers.dart';
import 'package:firepod/site/site.dart';
import 'package:settings/settings_object/settings_object_providers.dart';

abstract class FirepodSettings {
  static final site = SettingsObjectProviders<Site?>(
    key: '__SITE__',
    label: 'Site',
    hint: 'Site to be managed.',
    listProvider: FirepodProviders.siteListProvider,
    none: Site.none,
    getId: (site) => site == null ? '' : site.id,
    getLabel: (site) => site == null ? '' : site.name,
  );
}
