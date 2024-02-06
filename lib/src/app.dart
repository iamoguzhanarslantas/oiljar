import 'package:flutter/material.dart';

import 'package:oiljar/src/home/home.dart' show PickerHomePage, UserHomePage;
import 'package:oiljar/src/login/login.dart' show SignInPage, SignUpPage;
import 'package:oiljar/src/widgets/qr_scanner.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SignInPage.routeName,
      routes: {
        PickerHomePage.routeName: (context) => const PickerHomePage(),
        SignInPage.routeName: (context) => const SignInPage(),
        SignUpPage.routeName: (context) => const SignUpPage(),
        UserHomePage.routeName: (context) => const UserHomePage(),
        QRScanner.routeName: (context) => const QRScanner(),
      },
    );
  }
}
