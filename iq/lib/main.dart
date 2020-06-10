import 'package:flutter/material.dart';

import 'categories/categories_ui.dart';
import 'categories/utilities.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final SharedPrefs sharedPrefs = SharedPrefs();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome to Flutter',
      home: ButtonImplementation(sharedPrefs),
    );
  }
}
