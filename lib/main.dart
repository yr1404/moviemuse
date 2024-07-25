import 'package:flutter/material.dart';
import 'package:moviemuse/pages/welcome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MovieMuse',
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: HomePage(),
    );
  }
}
