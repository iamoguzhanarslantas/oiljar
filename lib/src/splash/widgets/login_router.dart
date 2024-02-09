import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:oiljar/src/home/home.dart' show PickerHomePage, UserHomePage;
import 'package:oiljar/src/login/login.dart' show SignInPage;
import 'package:oiljar/src/services/services.dart'
    show PickerRepository, UserRepository;

Future<void> loginRouter(
    {required User? user, required BuildContext context}) async {
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
    debugPrint('Email does not exist');
  }
}
