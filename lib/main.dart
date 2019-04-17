import 'package:flutter/material.dart';
import './ui/SignIn.dart';
import './ui/SignUp.dart';
import './ui/SignUp3.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carolies-Count-App',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      debugShowCheckedModeBanner: false,
      home: new SignUp3(),
    );
  }
}
