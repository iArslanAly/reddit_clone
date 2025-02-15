// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redit_clone/core/constants/constants.dart';
import 'package:redit_clone/core/utils.dart';
import 'package:redit_clone/views/auth/controller/auth_controller.dart';
import 'package:routemaster/routemaster.dart';

import '../../../models/community_models.dart';
import '../repository/community_repository.dart';

final userCommunitiesProvider = StreamProvider((ref) {
  final communityController = ref.watch(communityControllerProvider.notifier);
  return Stream.fromFuture(communityController.getCommunities());
});

// ignore: non_constant_identifier_names
final communityControllerProvider =
    StateNotifierProvider<CommunityController, bool>((ref) {
  final communityRepository = ref.watch(communityRepositoryProvider);
  return CommunityController(
      communityRepository: communityRepository, ref: ref);
});

class CommunityController extends StateNotifier<bool> {
  final CommunityRepository _communityRepository;
  // ignore: unused_field
  final Ref _ref;
  CommunityController(
      {required CommunityRepository communityRepository, required Ref ref})
      : _communityRepository = communityRepository,
        _ref = ref,
        super(false);

  void createCommunity(String name, BuildContext context) async {
    state = true;
    final DateTime createdAt = DateTime.now();
    final uid = _ref.read(userProvider)?.uid;
    if (uid == null || uid.isEmpty) {
      showSnackbar(context, 'Error: User not found. Please log in again.');
      state = false;
      return;
    }
    CommunityModels community = CommunityModels(
        id: name,
        name: name,
        banner: Constants.bannerDefault,
        avatar: Constants.avatarDefault,
        createdAt: createdAt.toString(),
        members: [uid],
        mods: [uid]);
    final res = await _communityRepository.createCommunity(community);
    state = false;
    res.fold(
      (failure) {
        if (kDebugMode) {
          print("Error creating community: ${failure.message}");
        } // Debug log
        showSnackbar(context, failure.message);
      },
      (_) {
        if (kDebugMode) {
          print("Community created successfully: ${community.name}");
        } // Debug log
        showSnackbar(context, 'Community created successfully');
        Routemaster.of(context).pop();
      },
    );
  }

  Future<List<CommunityModels>> getCommunities() {
    final uid = _ref.read(userProvider)?.uid;
    if (uid == null || uid.isEmpty) {
      return Future.value([]);
    }
    return _communityRepository.getCommunities(uid);
  }
}
