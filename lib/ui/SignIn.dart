import 'package:flutter/material.dart';
import './SignUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './Home.dart';
import 'package:flutter/scheduler.dart';

//ANCHOR This Start of Signin class


class SignIn extends StatefulWidget{
  
  //call sign in state
  @override
  SignInState createState() => new SignInState();

}

class SignInState extends State<SignIn>{

  String _email, _password;
  final _formKey = GlobalKey<FormState>();
  
  //NOTE Start SignIn Interface
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      //body part
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: (){
                          signInFlutter();
                        },
                      child: Text('Sign In'),
                      ),
                      RaisedButton(
                        onPressed: (){
                          signUpFlutter();
                        },
                      child: Text('Sign Up'),
                      )
                    ],
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //NOTE connected to flutter
  Future<void> signInFlutter() async {
    final formState = _formKey.currentState;
    if(formState.validate()){
      formState.save();
      debugPrint(_email);
      debugPrint(_password);
      try{
        FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        //Firestore.instance.collection('users').document(user.uid).setData({ 'Age': '20', 'job': 'student', 'name': 'benning'});
        _navigateToHome(user);
      }catch(e){
        print(e.message);
      }
      
    }
  }

  //NOTE sign up page
  void signUpFlutter(){
      _navigateToSignUp();
  }

  void _navigateToSignUp() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUp()),
    );
  }

  void _navigateToHome(FirebaseUser user) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home(user: user)),
    );
  }
  
}
