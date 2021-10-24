import 'package:flutter/material.dart';
import 'package:pomodoro/telas/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xFF2A2B4D),
        primaryColor: Color(0xFF2A2B4D),
        // primarySwatch: Colors.yellow,
      ),
      home: Home(),
    );
  }
}
