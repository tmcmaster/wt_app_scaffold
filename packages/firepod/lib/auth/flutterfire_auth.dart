import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:utils/logging.dart';

// import '../firebase_options.dart';
import 'user_auth.dart';
import 'user_auth_result.dart';

// // TODO: Might need to move these into a class that gets instantiated by the application.
// //   this would enable application specific data to be passed at creation time.
// final firebaseAuthProvider = Provider<FirebaseAuth>(
//   name: 'firebaseAuthProvider',
//   (ref) => FirebaseAuth.instanceFor(app: Firebase.app('wix-admin')),
// );
//
// final userAuthProvider = StateNotifierProvider<FlutterfireAuthNotifier, UserAuth>(
//   name: 'userAuthProvider',
//   (ref) => FlutterfireAuthNotifier(ref),
// );

class FlutterfireAuthNotifier extends StateNotifier<UserAuth> {
  static final log = logger(FlutterfireAuthNotifier, level: Level.debug);

  static final LINK_EMAIL_SIGN_IN_ENABLED = true;

  final Ref ref;
  late StreamSubscription _streamListener;
  final FirebaseAuth firebaseAuth;

  late GoogleSignIn _googleSignIn;

  FlutterfireAuthNotifier(this.ref, {required this.firebaseAuth, required FirebaseOptions firebaseOptions})
      : super(UserAuth.none) {
    _streamListener = firebaseAuth.authStateChanges().listen((User? user) async {
      if (user == null) {
        log.d('User signed out');
        state = UserAuth.none;
      } else {
        log.d('User signed in: ${user.displayName}');
        // TODO: we need to check if the UID authorized in the database.
        // TODO: need to add firebase database support to this package (need to pass in which databaseProvider to use).
        // TODO: need to sort out how to userAuthProvider know about the database provider (maybe need to use family??).
        // TODO: might need to make this package a firebase package that has database and auth features.
        state = UserAuth(uuid: user.uid, name: user.displayName ?? '', email: user.email ?? '');
      }
    });

    _googleSignIn = GoogleSignIn(
      clientId: kIsWeb ? firebaseOptions.appId : firebaseOptions.androidClientId,
      scopes: <String>[
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
  }

  @override
  void dispose() {
    _streamListener.cancel();
    super.dispose();
  }

  Future<void> getUserProfile() async {
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('userProfile');
    final results = await callable();
    log.d(results.toString());
  }

  Future<void> logout() {
    log.d('signOut');
    return firebaseAuth.signOut();
  }

  Future<UserAuthResult> emailSignIn(String email, String password) {
    log.d('emailSignIn');
    return _waitForCredentials(firebaseAuth.signInWithEmailAndPassword(email: email, password: password));
  }

  Future<UserAuthResult> linkEmailSignIn(String email, String password) {
    if (!LINK_EMAIL_SIGN_IN_ENABLED) throw Exception('Linking email sign in support is disabled');

    final completer = Completer<UserAuthResult>();

    if (firebaseAuth.currentUser == null) {
      completer.completeError('User is not currently logging in.');
    } else {
      try {
        final credentials = EmailAuthProvider.credential(email: email, password: password);
        log.d('Email Provider ID: ${credentials.providerId}');
        firebaseAuth.currentUser?.linkWithCredential(credentials).then((credentials) async {
          final user = credentials.user;
          if (user != null) {
            completer.complete(UserAuthResult.success(
              UserAuth(
                uuid: user.uid,
                name: user.displayName ?? '',
                email: user.email ?? '',
              ),
            ));
          } else {
            completer.completeError('Could not create a linked email login');
          }
        }).onError((error, stackTrace) {
          final errorString = error.toString();
          log.d('(2) _handleCredentialsFuture errorString: $errorString');
          completer.completeError(errorString);
        });
      } catch (error) {
        final errorString = error.toString();
        log.d('(3) _handleCredentialsFuture errorString: $errorString');
        completer.completeError(errorString);
      }
    }

    return completer.future;
  }

  Future<UserAuthResult> unlinkEmailSignIn(String email, String password) {
    if (!LINK_EMAIL_SIGN_IN_ENABLED) throw Exception('Linking email sign in support is disabled');

    final completer = Completer<UserAuthResult>();

    if (firebaseAuth.currentUser == null) {
      completer.completeError('User is not currently logging in.');
    } else {
      try {
        final credentials = EmailAuthProvider.credential(email: email, password: password);
        log.d('Email Provider ID: ${credentials.providerId}');
        completer.completeError('WIP');
        firebaseAuth.currentUser
            ?.unlink(credentials.providerId)
            .then((value) => log.d(value))
            .onError((error, stackTrace) => log.e(error));
      } catch (error) {
        final errorString = error.toString();
        log.d('(3) _handleCredentialsFuture errorString: $errorString');
        completer.completeError(errorString);
      }
    }

    return completer.future;
  }

  Future<UserAuthResult> createUser(String email, String password) {
    log.d('createUser');
    return _waitForCredentials(firebaseAuth.createUserWithEmailAndPassword(email: email, password: password));
  }

  Future<UserAuthResult> resetPassword(String email) {
    final completer = Completer<UserAuthResult>();

    log.d('resetPassword');
    firebaseAuth.sendPasswordResetEmail(email: email).then((result) {
      log.d('resetPassword : success');
      completer.complete(UserAuthResult.success(UserAuth.none));
    }).catchError((error, stacktrace) {
      log.d('resetPassword : error : ${error.toString()}');
      completer.complete(UserAuthResult.error(error.toString()));
    });

    return completer.future;
  }

  Future<UserAuthResult> anonymousSignIn() {
    log.d('anonymousSignIn');
    return _waitForCredentials(firebaseAuth.signInAnonymously());
  }

  Future<UserAuthResult> googleSignIn() {
    log.d('googleSignIn');
    final completer = Completer<UserAuthResult>();

    _createGoogleCredentials().then((credentials) {
      _waitForCredentials(firebaseAuth.signInWithCredential(credentials)).then((userAuthResults) {
        log.d('googleSignIn : success : ${userAuthResults.user.email}');
        completer.complete(userAuthResults);
      }).catchError((error) {
        log.d('googleSignIn : error : Could not get UserAuthResults: ${error.toString()}');
        completer.completeError("Could not get UserAuthResults: ${error.toString()}");
      });
    }).catchError((error) {
      log.d('googleSignIn : error : Could not get Google credentials: ${error.toString()}');
      completer.completeError("Could not get Google credentials: ${error.toString()}");
    });

    return completer.future;
  }

  Future<UserAuthResult> appleSignIn() async {
    log.d('appleSignIn');
    final completer = Completer<UserAuthResult>();

    _createAppleCredentials().then((oAuthCredential) {
      _waitForCredentials(firebaseAuth.signInWithCredential(oAuthCredential)).then((userAuthResults) {
        completer.complete(userAuthResults);
      }).catchError((error) {
        completer.completeError("Could not get the UserAuthResults: ${error.toString()}");
      });
    }).catchError((error) {
      completer.completeError("Could not get the Apple credentials: ${error.toString()}");
    });

    return completer.future;
  }

  Future<UserAuthResult> phoneSignIn(mobileNumber) async {
    final completer = Completer<UserAuthResult>();

    log.d('phoneSignIn: mobile number: $mobileNumber');
    firebaseAuth.signInWithPhoneNumber(mobileNumber).then((confirmationResult) {
      completer.complete(UserAuthResult.confirmation(confirmationResult));
    }).onError((error, stackTrace) {
      completer.complete(UserAuthResult.error(error.toString()));
    });

    return completer.future;
  }

  Future<UserAuthResult> verifyPhoneNumber(ConfirmationResult confirmationResult, String verificationCode) async {
    return _waitForCredentials(confirmationResult.confirm(verificationCode));
  }

  Future<OAuthCredential> _createAppleCredentials() {
    final completer = Completer<OAuthCredential>();

    log.d('_createAppleCredentials');
    const charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    final rawNonce = List.generate(32, (_) => charset[random.nextInt(charset.length)]).join();
    final bytes = utf8.encode(rawNonce);
    final digest = sha256.convert(bytes);
    final nonce = digest.toString();
    SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    ).then((appleCredential) {
      final oAuthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );
      completer.complete(oAuthCredential);
    }).catchError((error) {
      completer.completeError('Could mot get Apple ID credentials.');
    });

    return completer.future;
  }

  Future<OAuthCredential> _createGoogleCredentials() {
    final completer = Completer<OAuthCredential>();

    log.d('_createGoogleCredentials');
    // GoogleSignIn().signIn().then((googleUser) {
    _googleSignIn.signIn().then(
      (googleUser) {
        if (googleUser == null) {
          completer.completeError("User is not logged into Google.");
        } else {
          googleUser.authentication.then((googleAuth) {
            final oAuthCredential = GoogleAuthProvider.credential(
              accessToken: googleAuth.accessToken,
              idToken: googleAuth.idToken,
            );
            completer.complete(oAuthCredential);
          }).catchError((error) {
            completer.completeError("Could not get googleAuth: ${error.toString()}");
          });
        }
      },
      onError: (error) {
        completer.completeError("Could not sign in user: ${error.toString()}");
      },
    );

    return completer.future;
  }

  Future<UserAuthResult> _waitForCredentials(Future<UserCredential> credentialFuture) {
    final completer = Completer<UserAuthResult>();
    log.d('_handleCredentialsFuture: Handling credentials....');
    try {
      credentialFuture.then((credentials) async {
        final userAuthResult = _processCredentials(credentials);
        log.d('(1) _handleCredentialsFuture successString: ${userAuthResult.user.email}');
        completer.complete(userAuthResult);
      }).onError((error, stackTrace) {
        final errorString = error.toString();
        log.d('(2) _handleCredentialsFuture errorString: $errorString');
        log.d('(2) _handleCredentialsFuture errorString: ${error}');
        completer.completeError(errorString);
      });
    } catch (error) {
      final errorString = error.toString();
      log.d('(3) _handleCredentialsFuture errorString: $errorString');
      completer.completeError(errorString);
    }
    return completer.future;
  }

  UserAuthResult _processCredentials(UserCredential credentials) {
    log.d('_handleCredentials: $credentials');

    try {
      final user = credentials.user;
      if (user == null) {
        return UserAuthResult.error('Credentials did not contain a user.');
      }

      log.d('New user has been created: $user');

      final userAuth = UserAuth(
        uuid: user.uid,
        name: user.displayName ?? '',
        email: user.email ?? '',
      );
      state = userAuth;

      log.d('user has been updated: $user');

      return UserAuthResult.success(userAuth);
    } catch (error) {
      return UserAuthResult.error(error.toString());
    }
  }
}
