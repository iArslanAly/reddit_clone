import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redit_clone/theme/pallete.dart';
import 'package:redit_clone/views/auth/controller/auth_controller.dart';

class SignInButton extends ConsumerWidget {
  const SignInButton({super.key});

  void sigInwithGoogle(BuildContext context, WidgetRef ref) {
    ref.read(authControllerProvider.notifier).signInWithGoogle(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ElevatedButton.icon(
        onPressed: () => sigInwithGoogle(context, ref),
        icon: Image.asset('assets/images/google.png', height: 40),
        label: Text(
          'Continue With Google',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.poppins().fontFamily),
        ),
        style: ElevatedButton.styleFrom(
            backgroundColor: Pallete.blueColor,
            minimumSize: Size(double.infinity, 50),
            foregroundColor: Colors.white),
      ),
    );
  }
}
