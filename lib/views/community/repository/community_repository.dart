import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:redit_clone/core/constants/firebase_constants.dart';
import 'package:redit_clone/core/failure.dart';
import 'package:redit_clone/views/auth/providers/firebase_provider.dart';
import 'package:redit_clone/models/community_models.dart';

final communityRepositoryProvider = Provider((ref) {
  return CommunityRepository(firestore: ref.watch(firestoreProvider));
});

class CommunityRepository {
  final FirebaseFirestore _firestore;
  CommunityRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  Future<Either<Failure, void>> createCommunity(
      CommunityModels community) async {
    try {
      if (community.name.trim().isEmpty) {
        return left(Failure('Community name cannot be empty'));
      }

      if (kDebugMode) {
        print(
            "Creating community: ${community.name} in ${FirebaseConstants.communnitiesCollection}");
      }

      var communityDoc = await _communityCollection.doc(community.name).get();
      if (communityDoc.exists) {
        return left(Failure('Community already exists'));
      }

      await _communityCollection.doc(community.name).set(community.toMap());
      return right(null);
    } on FirebaseException catch (e) {
      return left(Failure(e.message ?? 'Firebase error occurred'));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<List<CommunityModels>> getCommunities(String uid) async {
    try {
      var event =
          await _communityCollection.where('members', arrayContains: uid).get();

      List<CommunityModels> communities = [];
      for (var doc in event.docs) {
        var data = doc.data();
        print("Firestore Data: $data"); // 🔍 Debug log before parsing

        communities.add(CommunityModels.fromMap(data as Map<String, dynamic>));
      }

      return communities;
    } catch (e) {
      print("Error fetching communities: $e"); // 🛑 Catch and log errors
      return [];
    }
  }

  CollectionReference get _communityCollection =>
      _firestore.collection(FirebaseConstants.communnitiesCollection);
}
