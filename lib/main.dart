import 'package:flutter/material.dart';
import 'package:workout_tracking_app/ui/pages/MainScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await updateApiBaseUrl();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainScreen(),
      theme:
          ThemeData(fontFamily: 'Montserrat', primaryColor: Colors.lightBlue),
    );
  }
}
