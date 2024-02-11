import 'package:flutter/material.dart';

import 'package:oiljar/src/app.dart' show App;
import 'package:oiljar/src/utils/utils.dart' show AppStart;

void main() async {
  await AppStart().initApp();
  runApp(const App());
}
