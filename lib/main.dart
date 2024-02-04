import 'package:flutter/material.dart';

import 'package:oiljar/src/app.dart' show App;
import 'package:oiljar/src/services/services.dart' show firebaseInitService;

void main() {
  firebaseInitService();
  runApp(const App());
}
