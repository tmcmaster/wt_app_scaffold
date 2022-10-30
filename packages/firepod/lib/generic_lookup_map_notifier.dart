import 'package:firepod/firepod.dart';
import 'package:utils/logging.dart';
import 'package:utils/models/id_support.dart';

import 'firebase_setup.dart';

class GenericSiteDataNotifier<T> extends StateNotifier<T> {
  static final log = logger(GenericSiteDataNotifier);

  late ProviderSubscription _removeListener;

  final String prefixPath;
  final String? suffixPath;
  final T none;
  final T? Function(Object? json) decoder;

  GenericSiteDataNotifier({
    required Ref ref,
    required this.none,
    required this.prefixPath,
    this.suffixPath,
    required this.decoder,
  }) : super(none) {
    final site = ref.read(FirepodSettings.site.value);
    _readFromDatabase(ref, site);
    log.d('Listening to ${FirepodSettings.site.value.name} for changes.');
    _removeListener = ref.listen<IdSupport?>(FirepodSettings.site.value, (oldSite, newSite) {
      log.d('${FirepodSettings.site.value} has changed');
      _readFromDatabase(ref, newSite);
    }, onError: (error, _) {});
  }

  void _readFromDatabase(Ref ref, IdSupport? site) {
    if (site != null) {
      final siteId = site.getId();
      final database = ref.read(FirebaseSetup.instance.database);

      final dbRef = suffixPath == null
          ? database.ref(prefixPath).child(siteId)
          : database.ref(prefixPath).child(siteId).child(suffixPath!);

      log.d('PrefixPath($prefixPath), SiteId($siteId), SuffixPath($suffixPath)');

      dbRef.get().then((snapshot) {
        if (snapshot.exists) {
          state = decoder(snapshot.value) ?? none;
          log.d('Updated site data for ${site.getId()}');
        } else {
          log.w('Could not find the required site data for Site(${site.getId()}) Prefix($prefixPath)');
          state = none;
        }
      }, onError: (error) => log.e(error));
    } else {
      log.w('There was no site selected.');
      state = none;
    }
  }

  @override
  void dispose() {
    _removeListener.close();
    super.dispose();
  }
}
