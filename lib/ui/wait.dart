import 'package:flutter/material.dart';
import 'package:health_app/ui/Home.dart';
import 'package:health_app/ui/SignIn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wait extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WaitState();
  }
}

class WaitState extends State {
  final prefs = SharedPreferences.getInstance();

  @override
  Future initState() {
    super.initState();
    getLogin();
  }

  Future<String> getLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.get('user') ?? 0;
    if (user != 0) {
      print("Alrady login");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home(user)));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
