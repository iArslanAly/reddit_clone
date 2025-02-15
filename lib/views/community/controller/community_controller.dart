// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../models/community_models.dart';
import '../repository/community_repository.dart';

class CommunityController {
  final CommunityRepository _communityRepository;
  // ignore: unused_field
  final Ref _ref;
  CommunityController(
      {required CommunityRepository communityRepository, required Ref ref})
      : _communityRepository = communityRepository,
        _ref = ref;

  Future<List<Map<String, dynamic>>> getCommunities() async {
    return await _communityRepository.getCommunities();
  }

  Future<Either<dynamic, Future<void>>> createCommunity(
      CommunityModels community) async {
    return await _communityRepository.createCommunity(community);
  }
}
