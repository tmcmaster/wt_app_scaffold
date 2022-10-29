// class FirepodInit {
//   static final siteProvider = StateNotifierProvider<SettingsObjectNotifier<Site?>, Site?>(
//     name: "FirepodInit.siteProvider",
//     (ref) => throw Exception('The FirepodInit.siteProvider needs to be overridden'),
//   );
//
//   static final firebaseDatabaseProvider = Provider<FirebaseDatabase>(
//     name: "FirepodInit.firebaseDatabaseProvider",
//     (ref) => throw Exception('The FirepodInit.firebaseDatabaseProvider needs to be overridden'),
//   );
//
//   static final firebaseAuthProvider = Provider<FirebaseAuth>(
//     name: "FirepodInit.firebaseAuthProvider",
//     (ref) => throw Exception('The FirepodInit.firebaseAuthProvider needs to be overridden'),
//   );
//
//   static List<Override> overrides({
//     required StateNotifierProvider<SettingsObjectNotifier<Site?>, Site?> siteProvider,
//   }) {
//     print('======= Overriding the FirepodInit providers');
//     return [
//       FirepodInit.siteProvider.overrideWithProvider(siteProvider),
//       FirepodInit.firebaseDatabaseProvider.overrideWithProvider(FirebaseSetup.instance.database),
//       FirepodInit.firebaseAuthProvider.overrideWithProvider(FirebaseSetup.instance.auth),
//     ];
//   }
// }
