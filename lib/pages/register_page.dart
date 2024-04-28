import 'package:flutter/material.dart';
import 'package:gogo/Services/auth_service.dart';
import 'package:gogo/components/my_button.dart';
import 'package:gogo/components/my_text_field.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
//text Controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final ConfirmpasswordController = TextEditingController();

  //sign up user
  void signUp() async {
    if (passwordController.text != ConfirmpasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Passwords do not Match")));
    }

    //auth Service
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signUpWithEmailandPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
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
                  size: 100,
                  color: Colors.lightBlue.shade400,
                ),
                const SizedBox(height: 10), // Add spacing
                // Creation de compte
                Text(
                  "Inscrire",
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
                    controller: passwordController,
                    hintText: 'Mot de Passe',
                    obscureText: true),

                //Confirmer mot de passe
                MyTextField(
                    controller: ConfirmpasswordController,
                    hintText: 'Confirmez votre Mot de Passe',
                    obscureText: true),
                //sign up button
                MyButton(onTap: signUp, text: "Inscrivez"),
                const SizedBox(height: 50),
                //subscribe button

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('vous êtes déja inscrit ?'),
                    SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login',
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
