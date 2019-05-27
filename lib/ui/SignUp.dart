import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_app/ui/ButtonGradient.dart';
import 'package:health_app/ui/SignIn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_app/ui/alert_ok.dart';
import 'package:progress_indicators/progress_indicators.dart';

class RegisterScreen extends StatefulWidget {
  Map dataRegis = new Map();
  RegisterScreen(this.dataRegis);
  @override
  State<RegisterScreen> createState() {
    return RegisterScreenState(dataRegis);
  }
}

class RegisterScreenState extends State<RegisterScreen> {
  Map dataRegis = new Map();
  RegisterScreenState(this.dataRegis);
  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    print(dataRegis);
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Center(
          child: SingleChildScrollView(
            child: Container(
              child: Padding(
                padding:
                    EdgeInsets.only(top: 0, left: 18, right: 18, bottom: 0),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Check Information",
                      style: TextStyle(fontSize: 30),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: 0, right: 0, bottom: 30, top: 30),
                      child: Column(
                        children: <Widget>[
                          Container(
                              child: new Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                new Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                        height: 30,
                                        child: Text("Username",
                                            style: TextStyle(fontSize: 20))),
                                    Container(
                                      child: Text(dataRegis['username'],
                                          style: TextStyle(fontSize: 18)),
                                    ),
                                  ],
                                ),
                                new Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                        height: 30,
                                        child: Text("Email",
                                            style: TextStyle(fontSize: 20))),
                                    Container(
                                      child: Text(dataRegis['email'],
                                          style: TextStyle(fontSize: 18)),
                                    ),
                                  ],
                                ),
                                new Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                        height: 30,
                                        child: Text("Genger",
                                            style: TextStyle(fontSize: 20))),
                                    Container(
                                      child: Text(dataRegis['gen'],
                                          style: TextStyle(fontSize: 20)),
                                    ),
                                  ],
                                ),
                                new Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                        height: 30,
                                        child: Text("Date of Birth",
                                            style: TextStyle(fontSize: 20))),
                                    Container(
                                      child: Text(dataRegis['dob'],
                                          style: TextStyle(fontSize: 20)),
                                    ),
                                  ],
                                ),
                                new Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                        height: 30,
                                        child: Text("Age",
                                            style: TextStyle(fontSize: 20))),
                                    Container(
                                      child: Text(
                                          dataRegis['age'].toString() +
                                              ' Years',
                                          style: TextStyle(fontSize: 20)),
                                    ),
                                  ],
                                ),
                                new Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                        height: 30,
                                        child: Text("Height",
                                            style: TextStyle(fontSize: 20))),
                                    Container(
                                      child: Text(dataRegis['height'] + ' cm.',
                                          style: TextStyle(fontSize: 20)),
                                    ),
                                  ],
                                ),
                                new Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                        height: 30,
                                        child: Text("Weight",
                                            style: TextStyle(fontSize: 20))),
                                    Container(
                                      child: Text(dataRegis['weight'] + ' Kg.',
                                          style: TextStyle(fontSize: 20)),
                                    ),
                                  ],
                                ),
                              ])),
                        ],
                      ),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FlatGradientButton(
                            width: 100,
                            child: Text(
                              'Previous',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            gradient: LinearGradient(
                              colors: <Color>[
                                Color(0xFF3366FF),
                                Color(0xFF00CCFF)
                              ],
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                        FlatGradientButton(
                            width: 120,
                            child: Text(
                              'Create Account',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            gradient: LinearGradient(
                              colors: <Color>[
                                Color(0xFF3366FF),
                                Color(0xFF00CCFF)
                              ],
                            ),
                            onPressed: () {
                              setState(() {
                                loading = true;
                              });
                              auth
                                  .createUserWithEmailAndPassword(
                                      email: dataRegis['email'],
                                      password: dataRegis['password'])
                                  .then((FirebaseUser user) {
                                Firestore.instance.runTransaction(
                                    (Transaction transaction) async {
                                  DocumentReference reference = Firestore
                                      .instance
                                      .collection('users')
                                      .document('${user.uid}');
                                  await reference.setData({
                                    "username": dataRegis['username'],
                                    "email": dataRegis["email"],
                                    "gender": dataRegis['gen'],
                                    "dob": dataRegis['dob'],
                                    "age": dataRegis['age'],
                                    "height": dataRegis['height'],
                                    "weight": dataRegis['weight'],
                                    'bmr': dataRegis['bmr'],
                                    'urlProfilea':
                                        "https://img.icons8.com/color/48/000000/user-male-circle.png"
                                  });
                                });
                                Firestore.instance.runTransaction(
                                    (Transaction transaction) async {
                                  DocumentReference reference = Firestore
                                      .instance
                                      .collection('users')
                                      .document('${user.uid}')
                                      .collection('all_exercise_add')
                                      .document();
                                  await reference.setData({
                                    "0": '0',
                                  });
                                });
                                user.sendEmailVerification().then((user) {
                                  setState(() {
                                    loading = false;
                                  });
                                  showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            title: Text("Will be completed"),
                                            content: Text(
                                                "We will sent Verify in your Email. Please Check in your Email, find 'noreply' and get Link"),
                                            actions: <Widget>[
                                              FlatButton(
                                                  child: Text("Ok"),
                                                  onPressed: () =>
                                                      auth.signOut().then((_) {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        LoginScreen()));
                                                      })
                                                  // Navigator.push(
                                                  //     context,
                                                  //     MaterialPageRoute(
                                                  //         builder: (context) =>
                                                  //             LoginScreen()))
                                                  )
                                            ],
                                          ));
                                });
                                print("return from firebase ${user.email}");
                              }).catchError((error) {
                                setState(() {
                                  loading = false;
                                });
                                alert_box(
                                    "The email address is already in use by another account",
                                    "Please Login in this Account",
                                    context);
                              });
                            }),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        _showCircularProgress(),
      ],
    ));
  }
}
