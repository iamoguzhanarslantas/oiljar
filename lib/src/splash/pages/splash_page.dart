import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:oiljar/src/services/services.dart' show AuthRepository;
import 'package:oiljar/src/splash/splash.dart' show loginRouter;

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
            return Center(
              child: Image.asset('assets/lottie/oil_money.gif'),
            );
          } else if (snapshot.connectionState == ConnectionState.active) {
            loginRouter(user: user, context: context);
          } else if (snapshot.connectionState == ConnectionState.done) {
            return const Center(
              child: Text('Connection state done'),
            );
          }
          return Center(
            child: Image.asset('assets/lottie/oil_money.gif'),
          );
        },
      ),
    );
  }
}
