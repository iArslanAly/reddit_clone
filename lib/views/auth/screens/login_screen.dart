import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redit_clone/core/common/loadeer.dart';

import 'package:redit_clone/core/common/sign_in_button.dart';
import 'package:redit_clone/views/auth/controller/auth_controller.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: Icon(
          Icons.reddit,
          size: 45,
        ),
        actions: [
          TextButton(onPressed: () {}, child: Text('Skip')),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Dive into Anything',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
          ),
          Icon(
            Icons.reddit,
            size: 400,
            color: Color.fromARGB(255, 207, 94, 7),
          ),
          isLoading ? Loader() : SignInButton(),
        ],
      ),
    );
  }
}
