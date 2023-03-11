import 'package:buddies/screens/auth/login_screen.dart';
import 'package:buddies/screens/auth/signup_screen.dart';

import 'package:flutter/material.dart';

class AuthPages extends StatelessWidget {
  const AuthPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: const [
        LoginScreen(),
        SignUpScreen(),

      ],
    );
  }
}
