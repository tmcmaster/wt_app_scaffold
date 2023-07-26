import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wt_firepod/wt_firepod.dart';
import 'package:wt_models/wt_models.dart';

mixin FirebaseData {
  static final requirementsIndex = FirepodObject<JsonMap>(
    name: 'Requirements Index',
    decoder: Dsl.firebaseMapDecoder,
    encoder: Dsl.firebaseMapEncoder,
    none: {},
    path: 'v2/definitions/index',
  );

  static final firebaseAuthProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

  static final authStateChangesProvider =
      StreamProvider<User?>((ref) => ref.watch(firebaseAuthProvider).authStateChanges());

  static final firebaseDatabase =
      Provider<FirebaseDatabase>((ref) => ref.read(FirebaseProviders.database));
}
