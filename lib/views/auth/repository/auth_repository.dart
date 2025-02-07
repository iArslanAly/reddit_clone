import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:redit_clone/core/constants/constants.dart';
import 'package:redit_clone/core/constants/firebase_constants.dart';
import 'package:redit_clone/core/failure.dart';
import 'package:redit_clone/core/type_def.dart';
import 'package:redit_clone/models/user_model.dart';
import 'package:redit_clone/views/auth/providers/firebase_provider.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    firestore: ref.read(firestoreProvider),
    auth: ref.read(authProvider),
    googleSignIn: ref.read(googleSignnInProvider),
  ),
);

class AuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;
  AuthRepository({
    required firestore,
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
  })  : _firestore = firestore,
        _auth = auth,
        _googleSignIn = googleSignIn;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  FutureEither<UserModel> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      final user = userCredential.user;
      UserModel userModel;
      if (userCredential.additionalUserInfo!.isNewUser) {
        userModel = UserModel(
            uid: user!.uid,
            name: user.displayName ?? '',
            email: user.email ?? '',
            photoUrl: user.photoURL ?? Constants.avatarDefault,
            banner: Constants.bannerDefault,
            isAuthenticated: true,
            karma: 0,
            awards: []);
        await _users.doc(user.uid).set(userModel.toMap());
      } else {
        userModel = await getUserData(user!.uid).first;
      }

      if (kDebugMode) {
        print(user.photoURL);
        print(user.isAnonymous);
        print(userCredential);
        print(userCredential.user?.email);
        print(user.displayName);
      }
      return right(userModel);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return left(Failure(e.toString()));
    }
  }

  Stream<UserModel> getUserData(String uid) {
    return _users.doc(uid).snapshots().map((event) {
      return UserModel.fromMap(event.data() as Map<String, dynamic>);
    });
  }
}
