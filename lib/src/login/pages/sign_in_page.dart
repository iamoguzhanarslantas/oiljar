import 'package:flutter/material.dart';

import 'package:oiljar/src/home/home.dart' show PickerHomePage, UserHomePage;
import 'package:oiljar/src/login/login.dart' show SignUpOption, SignUpPage;
import 'package:oiljar/src/services/services.dart'
    show AuthRepository, PickerRepository, UserRepository;
import 'package:oiljar/src/widgets/widgets.dart'
    show CustomElevatedButton, CustomTextField;

class SignInPage extends StatefulWidget {
  static const String routeName = '/sign-in';
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              controller: emailController,
              icon: Icons.email,
              isPasswordType: false,
              labeltext: 'Email',
            ),
            CustomTextField(
              controller: passwordController,
              icon: Icons.lock,
              isPasswordType: true,
              labeltext: 'Password',
            ),
            CustomElevatedButton(
              onPressed: () {
                if (emailController.text.isEmpty ||
                    passwordController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill all the fields'),
                    ),
                  );
                  return;
                }
                if (passwordController.text.length < 6) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Password must be at least 6 characters'),
                    ),
                  );
                  return;
                }
                AuthRepository()
                    .signIn(
                  emailController.text.trim(),
                  passwordController.text.trim(),
                )
                    .then(
                  (value) async {
                    var isPickerEmailExist = await PickerRepository()
                        .checkIfPickerEmailExists(emailController.text.trim());
                    var isUserEmailExist = await UserRepository()
                        .checkIfUserEmailExists(emailController.text.trim());
                    if (isPickerEmailExist && context.mounted) {
                      debugPrint(
                          'Picker Email Sign In ${emailController.text.trim()}');
                      Navigator.pushNamed(context, PickerHomePage.routeName);
                    } else if (isUserEmailExist && context.mounted) {
                      debugPrint(
                          'User Email Sign In ${emailController.text.trim()}');
                      Navigator.pushNamed(context, UserHomePage.routeName);
                    } else {
                      debugPrint('Email does not exist');
                    }
                  },
                ).catchError((error) {
                  debugPrint('Failed to sign in: $error');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Failed to sign in'),
                    ),
                  );
                });
              },
              text: 'Sign In',
            ),
            SignUpOption(
              text: 'Don\'t have an account?',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const SignUpPage();
                    },
                  ),
                );
              },
              buttonText: 'Sign Up',
            ),
          ],
        ),
      ),
    );
  }
}
