import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_app/ui/SignIn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  String _email, _password;
  final _formKey = GlobalKey<FormState>();


  FirebaseUser user;

  String _datetime = '';
  int _year;
  int _month;
  int _date;

  String _lang = 'i18n';
  String _format = 'yyyy-mm-dd';
  bool _showTitleActions = true;

  TextEditingController _langCtrl = TextEditingController();
  TextEditingController _formatCtrl = TextEditingController();
  var txt = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _langCtrl.text = 'i18n';
    _formatCtrl.text = 'yyyy-mm-dd';

    DateTime now = DateTime.now();
    _year = now.year;
    _month = now.month;
    _date = now.day;
  }

  void _onFocusChange() {
    _showDatePicker();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var blue = Colors.blue;
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    validator: (input) {
                      if (input.isEmpty) {
                        return 'Please fill the form';
                      }
                    },
                    onSaved: (input) => _email = input,
                    decoration: InputDecoration(labelText: 'Email'),
                  ),

                  //SECTION password
                  TextFormField(
                    validator: (input) {
                      if (input.isEmpty) {
                        return 'Please fill the password';
                      } else if (input.length < 6) {
                        return 'Your password is less than 6 letter';
                      }
                    },
                    onSaved: (input) => _password = input,
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    child: TextFormField(
                      controller: txt,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.date_range,
                          size: 28.0,
                        ),
                        suffixIcon: IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                _showDatePicker();
                                txt.text = "";
                              });
                            }),
                        labelText: "Date Of Birth"
                      ),
                    ),
                  ),
                  new Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    child: Column(
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () {
                            signUpFlutter();
                          },
                          child: Text('Sign Up'),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signUpFlutter() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      debugPrint(_email);
      debugPrint(_password);
      try {
        this.user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);
        _addData();
      } catch (e) {
        print(e.message);
      }
    }
  }

  void _navigateToSignIn() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignIn()),
    );
  }

  void _addData() {
    Firestore.instance.runTransaction((Transaction transaction) async {
      DocumentReference reference =
          Firestore.instance.collection('users').document('${user.uid}');
      await reference.setData({"name": 'benning', "age": 20, "job": 'student'});
    });
    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    DatePicker.showDatePicker(
      context,
      showTitleActions: _showTitleActions,
      minYear: 1970,
      maxYear: 2020,
      initialYear: _year,
      initialMonth: _month,
      initialDate: _date,
      confirm: Text(
        'custom ok',
        style: TextStyle(color: Colors.red),
      ),
      cancel: Text(
        'custom cancel',
        style: TextStyle(color: Colors.cyan),
      ),
      locale: _lang,
      dateFormat: _format,
      onChanged: (year, month, date) {},
      onConfirm: (year, month, date) {
        _date = date;
        _year = year;
        _month = month;
        debugPrint("$_date : $_month : $_year");
        txt.text =
            _date.toString() + "/" + _month.toString() + "/" + _year.toString();
      },
    );
  }
}
