import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
      appBar: AppBar(title: Text("Add Food")),
      body: BlocBuilder<CounterEvent, int>(
        bloc: _counterBlog,
        builder: (BuildContext context, int count) {
          return Column(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Container(
                  // color: Colors.cyan,
                  padding: EdgeInsets.only(top: 40, left: 20, right: 20),
                  height: ((MediaQuery.of(context).size.height) / 2) - 20,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Text(
                          _listFood['name'],
                          style: TextStyle(fontSize: 40.0),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text("$count " + _listFood['unit']),
                      Text("~" +
                          (int.parse(_listFood['cal']) * count).toString()),
                    ],
                  ),
                ),
              ),
              Stack(
                children: <Widget>[
                  Container(
                    // color: Colors.amberAccent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          child: Icon(
                            Icons.remove_circle_outline,
                            color: Colors.lightBlue,
                            size: 40,
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
                              style: TextStyle(fontSize: 40.0),
                            ),
                          ),
                        ),
                        InkWell(
                          child: Icon(
                            Icons.add_circle_outline,
                            color: Colors.lightBlue,
                            size: 40,
                          ),
                          onTap: () {
                            _counterBlog.dispatch(CounterEvent.increment);
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: ((MediaQuery.of(context).size.height) / 2) - 120,
                    // color: Colors.deepPurple,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: FlatButton(
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.greenAccent,
                          size: 70,
                        ),
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
                              'timestamp': DateTime.now(),
                            });
                          });
                          // Navigator.of(context)
                          //     .popUntil(ModalRoute.withName("routeName"));
                          Navigator.of(context)
                              .popUntil(ModalRoute.withName("routeName"));
                        },
                      ),
                    ),
                  ),
                ],
              )

              //   Container(
              //       color: Colors.blueGrey,
              //       child: Padding(
              //           padding: const EdgeInsets.only(top: 5.0),
              //           child: new StaggeredGridView.count(
              //             crossAxisCount: 6,
              //             staggeredTiles: <StaggeredTile>[
              //               const StaggeredTile.fit(6),
              //               const StaggeredTile.count(2, 2),
              //             ],
              //             children: <Widget>[
              //               const _Example01Tile(Text("Breakfast"),
              //                   AssetImage('assets/images/icon/1.png')),
              //               const _Example01Tile(Text("Lunch"),
              //                   AssetImage('assets/images/icon/2.png')),
              //             ],
              //             mainAxisSpacing: 0.0,
              //             crossAxisSpacing: 0.0,
              //             padding: const EdgeInsets.all(5.0),
              //           ))),
            ],
          );
        },
      ),
    );
  }
}

class _Example01Tile extends StatelessWidget {
  const _Example01Tile(this.text, this.icon);

  final Text text;
  final AssetImage icon;

  @override
  Widget build(BuildContext context) {
    return new Card(
        color: Colors.white,
        child: new InkWell(
            onTap: () {
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => MenuBook()));
            },
            child: Center(
              child: new Container(
                // height: 96,
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[Image(image: icon, width: 80.0), text],
                ),
              ),
            )));
  }
}
