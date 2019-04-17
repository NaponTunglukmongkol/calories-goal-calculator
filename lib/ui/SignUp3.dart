import 'package:flutter/material.dart';



class SignUp3 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SignUpState3();
}

class SignUpState3 extends State<SignUp3>{
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Text(
                    "3nd Step",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}