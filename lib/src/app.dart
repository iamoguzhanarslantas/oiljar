import 'package:flutter/material.dart';

import 'package:oiljar/src/home/home.dart' show PickerHomePage, UserHomePage;
import 'package:oiljar/src/login/login.dart' show SignInPage, SignUpPage;
import 'package:oiljar/src/splash/splash.dart' show SplashPage;
import 'package:oiljar/src/home/widgets/qr_scanner.dart' show QRScanner;

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: SplashPage.routeName,
      routes: {
        PickerHomePage.routeName: (context) => const PickerHomePage(),
        SignInPage.routeName: (context) => const SignInPage(),
        SignUpPage.routeName: (context) => const SignUpPage(),
        SplashPage.routeName: (context) => const SplashPage(),
        UserHomePage.routeName: (context) => const UserHomePage(),
        QRScanner.routeName: (context) => const QRScanner(),
      },
    );
  }
}
