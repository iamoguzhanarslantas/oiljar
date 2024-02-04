import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:oiljar/firebase_options.dart' show DefaultFirebaseOptions;

Future<void> firebaseInitService() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
