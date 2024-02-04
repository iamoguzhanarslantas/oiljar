import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:oiljar/src/login/login.dart' show SignInPage;
import 'package:oiljar/src/models/models.dart' show PickerModel, UserModel;
import 'package:oiljar/src/services/picker/picker_repository.dart'
    show PickerRepository;
import 'package:oiljar/src/services/services.dart'
    show AuthRepository, UserRepository;
import 'package:oiljar/src/utils/utils.dart' show ProfileEnum;
import 'package:oiljar/src/widgets/widgets.dart'
    show CustomElevatedButton, CustomListTileWithRadioButton, CustomTextField;

class SignUpPage extends StatefulWidget {
  static const String routeName = '/sign-up';
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ProfileEnum profileEnum = ProfileEnum.user;

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up User Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              controller: usernameController,
              icon: Icons.person,
              isPasswordType: false,
              labeltext: 'Username',
            ),
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
            CustomListTileWithRadioButton(
              title: 'User',
              value: ProfileEnum.user,
              groupValue: profileEnum,
              onChanged: (value) {
                setState(
                  () {
                    profileEnum = value as ProfileEnum;
                  },
                );
              },
            ),
            CustomListTileWithRadioButton(
              title: 'Picker',
              value: ProfileEnum.picker,
              groupValue: profileEnum,
              onChanged: (value) {
                setState(
                  () {
                    profileEnum = value as ProfileEnum;
                  },
                );
              },
            ),
            CustomElevatedButton(
              onPressed: () async {
                if (emailController.text.isEmpty ||
                    passwordController.text.isEmpty ||
                    usernameController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill all the fields'),
                    ),
                  );
                  return;
                }
                if (passwordController.text.length < 6 ||
                    usernameController.text.length < 6) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'Password or Username must be at least 6 characters'),
                    ),
                  );
                  return;
                }
                if (profileEnum == ProfileEnum.picker ||
                    profileEnum == ProfileEnum.user) {
                  var isPickerEmailExist = await PickerRepository()
                      .checkIfPickerEmailExists(emailController);
                  var isUserEmailExist = await UserRepository()
                      .checkIfUserEmailExists(emailController);
                  if (isPickerEmailExist && context.mounted ||
                      isUserEmailExist && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Email already exists'),
                      ),
                    );
                    return;
                  }
                }
                AuthRepository()
                    .signUp(
                  emailController.text.trim(),
                  passwordController.text.trim(),
                )
                    .then((value) async {
                  UserModel userModel = UserModel(
                    id: FirebaseAuth.instance.currentUser!.uid,
                    email: emailController.text.trim(),
                    username: usernameController.text.trim(),
                    password: passwordController.text.trim(),
                    profileType: profileEnum.name,
                  );
                  PickerModel pickerModel = PickerModel(
                    id: FirebaseAuth.instance.currentUser!.uid,
                    email: emailController.text.trim(),
                    username: usernameController.text.trim(),
                    password: passwordController.text.trim(),
                    profileType: profileEnum.name,
                  );
                  if (profileEnum == ProfileEnum.picker) {
                    await PickerRepository()
                        .savePicker(pickerModel)
                        .then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Picker Created'),
                        ),
                      );
                    });
                  } else if (profileEnum == ProfileEnum.user) {
                    await UserRepository().saveUser(userModel).then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('User Created'),
                        ),
                      );
                    });
                  }
                }).then((value) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      SignInPage.routeName, (route) => false);
                });
              },
              text: 'Sign Up',
            ),
          ],
        ),
      ),
    );
  }
}
