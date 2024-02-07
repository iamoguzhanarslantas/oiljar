import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oiljar/src/home/home.dart';
import 'package:oiljar/src/login/login.dart';
import 'package:oiljar/src/services/services.dart';

class SplashPage extends StatefulWidget {
  static const String routeName = '/splash';
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final user = AuthRepository().getCurrentUser();
  final streamUser = FirebaseAuth.instance.authStateChanges();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: streamUser,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.none) {
                return const Center(
                  child: Text('Connection state none'),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.connectionState == ConnectionState.active) {
                loginUser();
              } else if (snapshot.connectionState == ConnectionState.done) {
                return const Center(
                  child: Text('Connection state done'),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }

  Future<void> loginUser() async {
    var isPickerEmailExist =
        await PickerRepository().checkIfPickerEmailExists(user?.email);
    var isUserEmailExist =
        await UserRepository().checkIfUserEmailExists(user?.email);

    if (user == null && context.mounted) {
      await Navigator.pushReplacementNamed(context, SignInPage.routeName);
    } else if (isPickerEmailExist && context.mounted) {
      debugPrint('Picker Email Sign In');
      await Navigator.pushReplacementNamed(context, PickerHomePage.routeName);
    } else if (isUserEmailExist && context.mounted) {
      debugPrint('User Email Sign In');
      await Navigator.pushReplacementNamed(context, UserHomePage.routeName);
    } else {
      debugPrint('Email does not existtt');
    }
  }
}
