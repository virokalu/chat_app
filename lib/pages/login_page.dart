import 'package:app/components/custom_button.dart';
import 'package:app/components/custom_text_field.dart';
import 'package:flutter/material.dart';

import '../services/auth/auth_service.dart';

class LoginPage extends StatelessWidget {
  ///Email and Password Controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();

  //tap to go to register page
  final void Function()? onTap;

  LoginPage({super.key, required this.onTap});

  ///Login Method
  void login(BuildContext context) async {
    //auth here
    final authService = AuthService();

    try {
      await authService.signInWithEmailPwd(
          _emailController.text, _pwdController.text);
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(e.toString()),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ///Logo
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(
              height: 50,
            ),

            ///Message
            Text(
              "Welcome back, you're been missed!",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary, fontSize: 16),
            ),
            const SizedBox(
              height: 25,
            ),

            ///Email
            CustomTextField(
              hintText: 'Email',
              obscureText: false,
              controller: _emailController,
            ),
            const SizedBox(
              height: 10,
            ),

            ///Password
            CustomTextField(
              hintText: 'Password',
              obscureText: true,
              controller: _pwdController,
            ),
            const SizedBox(
              height: 25,
            ),

            ///Buttons
            CustomButton(
              text: 'Login',
              onTap: () => login(context),
            ),
            const SizedBox(
              height: 25,
            ),

            ///Register
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Not a member? ",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "Register Now",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
