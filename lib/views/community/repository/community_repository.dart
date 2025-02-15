import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:redit_clone/core/constants/firebase_constants.dart';
import 'package:redit_clone/core/failure.dart';
import 'package:redit_clone/views/auth/providers/firebase_provider.dart';
import 'package:redit_clone/views/community/models/community_models.dart';

final communityRepositoryProvider = Provider((ref) {
  return CommunityRepository(firestore: ref.watch(firestoreProvider));
});

class CommunityRepository {
  final FirebaseFirestore _firestore;

  CommunityRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<Either<dynamic, Future<void>>> createCommunity(
      CommunityModels community) async {
    try {
      var communityDoc = await _communityCollection.doc(community.name).get();
      if (communityDoc.exists) {
        throw Exception('Community already exists');
      }
      return right(
          _communityCollection.doc(community.name).set(community.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      throw left(Failure(e.toString()));
    }
  }

  Future<List<Map<String, dynamic>>> getCommunities() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('communities').get();
      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      throw Exception('Error fetching communities: $e');
    }
  }

  CollectionReference get _communityCollection =>
      _firestore.collection(FirebaseConstants.communnitiesCollection);
}
