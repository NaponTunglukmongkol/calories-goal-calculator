import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_app/ui/ButtonGradient.dart';
import 'package:health_app/ui/Home.dart';
import 'package:health_app/ui/SignUp1.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();

  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool loading = false;

  Widget _showCircularProgress() {
    if (loading) {
      return Container(
          color: Color.fromARGB(200, 255, 255, 255),
          child: Center(
            child: JumpingDotsProgressIndicator(
              fontSize: 80.0,
              milliseconds: 100,
              color: Colors.blueAccent,
              numberOfDots: 4,
              dotSpacing: 2,
            ),
          ));
    }
    return Container(
      width: 0,
      height: 0,
    );
  }

  Future<FirebaseUser> getUser() async {
    return await auth.currentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(40),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 200,
                    child: Image.asset("assets/img/2.png"),
                  ),
                  TextFormField(
                    controller: email,
                    decoration: InputDecoration(labelText: "Email"),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isEmpty) return "Email is required";
                    },
                  ),
                  TextFormField(
                    controller: password,
                    decoration: InputDecoration(labelText: "Password"),
                    obscureText: true,
                    validator: (value) {
                      if (value.isEmpty) return "Password is required";
                    },
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 30, bottom: 50),
                    child: FlatGradientButton(
                        width: 100,
                        child: Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        gradient: LinearGradient(
                          colors: <Color>[Color(0xFF3366FF), Color(0xFF00CCFF)],
                        ),
                        onPressed: () {
                          setState(() {
                            loading = true;
                          });
                          auth
                              .signInWithEmailAndPassword(
                            email: email.text,
                            password: password.text,
                          )
                              .then((FirebaseUser user) async {
                            if (user.isEmailVerified) {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString('user', '${user.uid}');
                              String userok = prefs.get('user');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home(userok)));
                            } else {
                              print(
                                  "Please check your email to verified account");
                              setState(() {
                                loading = false;
                              });
                              showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        title:
                                            Text("Please verified your Email"),
                                        content: Text(
                                            "Go to your email inbox and find latest 'noreply' and Click link from it"),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text("Ok"),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          )
                                        ],
                                      ));
                            }
                          }).catchError((error) {
                            print("$error");
                            setState(() {
                              loading = false;
                            });
                            showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: Text("Error"),
                                      content:
                                          Text("Email or Password not Correct"),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text("Ok"),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        )
                                      ],
                                    ));
                          });
                        }),
                  ),
                  FlatButton(
                    child: Text("Register new user"),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisFirst()));
                    },
                  )
                ],
              ),
            ),
          ),
        ),
        _showCircularProgress(),
      ],
    ));
  }
}
