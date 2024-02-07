import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:oiljar/firebase_options.dart' show DefaultFirebaseOptions;
import 'package:oiljar/src/app.dart' show App;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}
