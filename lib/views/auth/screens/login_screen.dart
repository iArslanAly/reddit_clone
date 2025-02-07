import 'package:flutter/material.dart';

import 'package:redit_clone/core/common/sign_in_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          SignInButton(),
        ],
      ),
    );
  }
}
