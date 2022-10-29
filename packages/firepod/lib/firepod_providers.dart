import 'dart:async';

import 'package:firepod/firebase_setup.dart';
import 'package:firepod/site/site.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings/settings_object/settings_object_notifier.dart';
import 'package:utils/logging.dart';

import 'auth/auth.dart';
import 'firepod_settings.dart';

abstract class FirepodProviders {
  static final siteListProvider = StateNotifierProvider<SiteListNotifier, List<Site>?>(
    name: 'siteListProvider',
    (ref) => SiteListNotifier(null, ref),
  );
}

class SiteListNotifier extends StateNotifier<List<Site>?> {
  final log = logger(SiteListNotifier);

  final Ref ref;
  late StreamSubscription _subscription;

  SiteListNotifier(super.state, this.ref) {
    _subscription = ref.read(FirebaseSetup.instance.auth).authStateChanges().listen((User? user) {
      final site = ref.read(FirepodSettings.site.value);
      final siteNotifier = ref.read(FirepodSettings.site.notifier);
      log.d('Settings site at login: ${site?.name}');
      if (user == null) {
        log.d('User logged out. Setting site list to an empty list');
        state = [];
      } else {
        log.d('User logged in');
        final userId = user.uid;
        log.d('Loading site data from the database for UserId($userId)');
        // TODO may need to change this to watch for changes. Restarting the app is fine for now.
        ref.read(FirebaseSetup.instance.database).ref('data').child(userId).child('sites').get().then((snapshot) {
          log.d('New site data loaded from the database.');
          if (snapshot.exists) {
            final siteMap = snapshot.value as Map<Object?, Object?>;
            state = siteMap.entries.map((e) => Site(id: e.key as String, name: e.value as String)).toList();
            log.i('Updated site list.');
            if (_siteIsLoaded(site)) {
              if (_siteIsInList(site)) {
                log.d('Site has loaded, and it appears in the new list of sites.');
              } else {
                log.d('Site does not appear in the new list of sites, so selecting the first site in the list.');
                _setSiteToFirstItemInList(siteNotifier);
              }
            } else {
              log.d('New site list has loaded. Site has not been loaded. Loading site.');
              siteNotifier.load();
            }
          } else {
            log.w('Could not find the site list for user: ${user.displayName}');
            state = [];
          }
        }, onError: (error) {
          log.e(error.toString());
          //ref.read(messageServiceProvider).error('User does not have required permission.');
        });
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  bool _siteIsLoaded(Site? site) {
    return site != null;
  }

  bool _siteIsInList(Site? site) {
    log.d('Checking if $site is in $state');
    return site != null && state != null && state!.contains(site);
  }

  void _setSiteToFirstItemInList(SettingsObjectNotifier<Site?> siteNotifier) {
    if (state != null && state!.isNotEmpty) {
      siteNotifier.replaceValue(state![0]);
    }
  }
}
