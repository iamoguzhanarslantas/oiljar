import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:oiljar/firebase_options.dart';

class AppStart {
  Future<void> initApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
