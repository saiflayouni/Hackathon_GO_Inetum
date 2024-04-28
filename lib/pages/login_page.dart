import 'package:flutter/material.dart';
import 'package:gogo/Services/auth_service.dart';
import 'package:gogo/components/my_button.dart';
import 'package:gogo/components/my_text_field.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
//text Controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //Sign In User
  Future<void> signIn() async {
    // Service de Auth
    final authService = Provider.of<AuthService>(context, listen: false);
    
    try{
      await authService.signInWithEmailandPassword(
        emailController.text,
        passwordController.text

      );

    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString(),),),);

    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade500,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                // Logo
                Icon(
                  Icons.message,
                  size: 80,
                  color: Colors.lightBlue.shade400,
                ),
                const SizedBox(height: 10), // Add spacing
                // Welcome message
                Text(
                  "Bienvenue Dans Go&Go",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                // Add your login form or other widgets here

                //email textfield
                MyTextField(
                    controller: emailController,
                    hintText: 'Votre Mail Inetum',
                    obscureText: false),
                //Password textfield
                MyTextField(
                    controller: emailController,
                    hintText: 'Mot de Passe',
                    obscureText: true),
                //sign in button
                MyButton(onTap: signIn, text: "Sign in"),
                const SizedBox(height: 50),
                //subscribe button

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('vous êtes pas inscrit ?'),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Inscrivez vous',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
