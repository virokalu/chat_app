import 'package:flutter/material.dart';

import '../components/custom_button.dart';
import '../components/custom_text_field.dart';
import '../services/auth/auth_service.dart';

class RegisterPage extends StatelessWidget {
  ///Email and Password Controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final TextEditingController _confirmPwdController = TextEditingController();

  //tap to go to login page
  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  ///Register Method
  void register(BuildContext context){
    final auth = AuthService();

    //passwords matching
    if(_pwdController.text == _confirmPwdController.text){
      try{
        auth.signUpWithEmailPassword(_emailController.text, _pwdController.text);
      }
      catch (e) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(e.toString()),
            ));
      }
    }
    //passwords not matching
    else{
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text("Passwords don't match"),
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
              "Let's create an account for you",
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
              height: 10,
            ),

            ///Password
            CustomTextField(
              hintText: 'Confirm Password',
              obscureText: true,
              controller: _confirmPwdController,
            ),
            const SizedBox(
              height: 25,
            ),

            ///Buttons
            CustomButton(
              text: 'Register',
              onTap: ()=> register(context),
            ),
            const SizedBox(
              height: 25,
            ),

            ///Login
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style:
                  TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "Login Now",
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
