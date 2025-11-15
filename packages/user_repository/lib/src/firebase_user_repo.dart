import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../user_repository.dart';

class FirebaseUserRepo implements UserRepository {
  final FirebaseAuth _firebaseAuth;
  final usersCollection = FirebaseFirestore.instance.collection('users');

  FirebaseUserRepo({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Stream<MyUser?> get user {
    // Use asyncMap to safely handle missing Firestore documents.
    return _firebaseAuth.authStateChanges().asyncMap((firebaseUser) async {
      if (firebaseUser == null) {
        return MyUser.empty;
      }

      try {
        final doc = await usersCollection.doc(firebaseUser.uid).get();
        final data = doc.data();
        if (data == null || !doc.exists) {
          // Document missing in Firestore: create an initial document so
          // subsequent reads succeed, then return the constructed MyUser.
          final initialUser = MyUser(
            userId: firebaseUser.uid,
            email: firebaseUser.email ?? '',
            name: firebaseUser.displayName ?? '',
            hasActiveCart: false,
          );

          try {
            await setUserData(initialUser);
          } catch (e) {
            // If creation fails (permissions, network), log and continue by
            // returning the minimal user — higher-level code can decide what
            // to do (e.g., prompt to retry or show an error).
            log('Failed to create initial user document: $e');
          }

          return initialUser;
        }

        return MyUser.fromEntity(MyUserEntity.fromDocument(data));
      } catch (e, st) {
        // Log and return an empty user to avoid unhandled stream errors.
        log('Error reading user document: $e');
        log(st.toString());
        return MyUser.empty;
      }
    });
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<MyUser> signUp(MyUser myUser, String password) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: myUser.email, password: password);

      myUser.userId = user.user!.uid;
      // Persist initial user document in Firestore so subsequent reads succeed.
      try {
        await setUserData(myUser);
      } catch (e) {
        // If set fails, log but still return the created auth user.
        log('Failed to set user data on signUp: $e');
      }

      return myUser;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> setUserData(MyUser myUser) async {
    try {
      await usersCollection
          .doc(myUser.userId)
          .set(myUser.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
