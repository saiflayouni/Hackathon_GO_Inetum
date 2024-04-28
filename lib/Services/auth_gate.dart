import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../pages/home_page.dart';
import 'login_or_register.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // User logged in
          if (snapshot.hasData) {
            return const HomePage();
          }
          // User not logged in
          else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
