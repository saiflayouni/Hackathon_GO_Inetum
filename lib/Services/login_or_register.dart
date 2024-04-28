import 'package:flutter/material.dart';
import 'package:gogo/pages/login_page.dart';
import 'package:gogo/pages/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  //montrer La page de Login
  bool showLoginPage = true;
  // Basculer entre Login et Inscription

  void basculerPage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: basculerPage);
    } else {
      return RegisterPage(onTap: basculerPage);
    }
  }
}
