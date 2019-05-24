import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_app/Boloc/counter_event.dart';
import 'package:health_app/ui/FoodUI.dart';
import 'package:health_app/ui/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Boloc/counterBloc.dart';

import 'package:path/path.dart';

class CounterPage extends StatelessWidget {
  String user = '';
  Map<String, String> _listFood;
  CounterPage(this._listFood);
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<String> getLogin() async {
    final prefs = await SharedPreferences.getInstance();
    this.user = prefs.get('user') ?? '0';
  }

  @override
  Widget build(BuildContext context) {
    getLogin();
    final CounterBloc _counterBlog = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      appBar: AppBar(title: Text("counter")),
      body: BlocBuilder<CounterEvent, int>(
        bloc: _counterBlog,
        builder: (BuildContext context, int count) {
          return Column(
            children: <Widget>[
              Container(
                height: 200,
                child: Column(
                  children: <Widget>[
                    Text(_listFood['name']),
                    Text("$count " + _listFood['unit']),
                    Text(
                        "~" + (int.parse(_listFood['cal']) * count).toString()),
                  ],
                ),
              ),
              Container(
                color: Colors.amberAccent,
                child: Row(
                  children: <Widget>[
                    InkWell(
                      child: Icon(
                        Icons.remove,
                        color: Colors.blue,
                        size: 30,
                      ),
                      onTap: () {
                        _counterBlog.dispatch(CounterEvent.decrement);
                      },
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(left: 15, right: 15),
                        child: Text(
                          '$count',
                          style: TextStyle(fontSize: 24.0),
                        ),
                      ),
                    ),
                    InkWell(
                      child: Icon(
                        Icons.add,
                        color: Colors.blue,
                        size: 30,
                      ),
                      onTap: () {
                        _counterBlog.dispatch(CounterEvent.increment);
                      },
                    ),
                  ],
                ),
              ),
              Container(
                child: RaisedButton(
                  child: Text("data"),
                  onPressed: () {
                    Firestore.instance
                        .runTransaction((Transaction transaction) async {
                      DocumentReference reference = Firestore.instance
                          .collection('users')
                          .document('$user')
                          .collection('all_food_add')
                          .document();
                      await reference.setData({
                        "name": _listFood['name'],
                        "unit": "$count " + _listFood['unit'],
                        "cal": (int.parse(_listFood['cal']) * count),
                        'hours': DateTime.now().hour,
                        'minute': DateTime.now().minute,
                        'day': DateTime.now().day,
                        'month': DateTime.now().month,
                        'year': DateTime.now().year,
                      });
                    });
                    // Navigator.of(context)
                    //     .popUntil(ModalRoute.withName("routeName"));
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FoodPage(user)));
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
