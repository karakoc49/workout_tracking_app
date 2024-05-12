import 'package:flutter/material.dart';
import 'package:workout_tracking_app/ui/pages/HomePage.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme:
          ThemeData(fontFamily: 'Montserrat', primaryColor: Colors.lightBlue),
    );
  }
}
