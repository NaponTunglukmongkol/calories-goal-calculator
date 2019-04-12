import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_app/ui/SignIn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_app/ui/dbSchema.dart';

class SignUp extends StatefulWidget{
  
  @override
  State<StatefulWidget> createState() => SignUpState();
}

class SignUpState extends State<SignUp>{
  String _email, _password;
  final _formKey = GlobalKey<FormState>();

  Replies _replyObj = new Replies(
    name: 'Test',
    age: 20,
    job: 'student'
  );

  FirebaseUser user;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var blue = Colors.blue;
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                TextFormField(
                  validator: (input){
                    if(input.isEmpty){
                      return 'Please fill the form';
                    }
                  },
                  onSaved: (input) => _email = input,
                  decoration: InputDecoration(
                    labelText: 'Email'
                  ),
                ),
                
                //SECTION password
                TextFormField(
                  validator: (input){
                    if(input.isEmpty){
                      return 'Please fill the password';
                    }else if(input.length < 6){
                      return 'Your password is less than 6 letter';
                    }
                  },
                  onSaved: (input) => _password = input,
                  decoration: InputDecoration(
                    labelText: 'Password'
                  ),
                  obscureText: true,
                ),
                new Container(
                  margin: const EdgeInsets.only(top:10.0),
                  child: Column(
                    children: <Widget>[
                      RaisedButton(
                        onPressed: (){
                          signUpFlutter();
                        },
                        child: Text('Sign Up'),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signUpFlutter() async {
    final formState = _formKey.currentState;
    if(formState.validate()){
      formState.save();
      debugPrint(_email);
      debugPrint(_password);
      try{
        this.user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
        debugPrint(user.uid);
        _addData();
      }catch(e){
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

  void _addData(){
    Firestore.instance.runTransaction((Transaction transaction) async {
      DocumentReference reference = Firestore.instance.collection('users').document('${user.uid}');
      await reference.setData({
        "name": 'benning',
        "age": 20,
        "job": 'student'
      });
    });
    Navigator.of(context).pop();
  }

}