import 'package:flutter/material.dart';

import 'package:oiljar/src/login/login.dart' show SignInPage;
import 'package:oiljar/src/services/services.dart' show AuthRepository;

class UserHomePage extends StatefulWidget {
  static const String routeName = '/user-home';
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  final user = AuthRepository().getCurrentUser();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Home Page'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (user != null) Text('Welcome ${user!.email}'),
            ElevatedButton(
              child: const Text('Sign Out'),
              onPressed: () {
                AuthRepository().signOut().then(
                      (value) => Navigator.pushNamedAndRemoveUntil(
                        context,
                        SignInPage.routeName,
                        (route) => false,
                      ),
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}
