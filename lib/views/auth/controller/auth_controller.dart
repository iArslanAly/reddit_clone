import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redit_clone/core/utils.dart';
import 'package:redit_clone/models/user_model.dart';
import 'package:redit_clone/views/auth/providers/firebase_provider.dart';
import 'package:redit_clone/views/auth/repository/auth_repository.dart';

final userProvider = StreamProvider.autoDispose<UserModel>(
  (ref) => ref.read(authRepositoryProvider).getUserData(
        ref.read(authProvider).currentUser!.uid,
      ),
);

final authControllerProvider = Provider(
    (ref) => AuthController(authRepository: ref.read(authRepositoryProvider)));

class AuthController {
  final AuthRepository _authRepository;
  AuthController({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  void signInWithGoogle(BuildContext context) async {
    final user = await _authRepository.signInWithGoogle();
    {
      user.fold(
        (l) => showSnackbar(context, l.message),
        (r) => print(r),
      );
    }
  }
}
