import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_app/Boloc/counter_event.dart';
import 'package:health_app/ui/FoodUI.dart';
import '../Boloc/counterBloc.dart';

import 'package:path/path.dart';

class CounterPage extends StatelessWidget {
  Map<String, String> _listFood;
  CounterPage(this._listFood);
  @override
  Widget build(BuildContext context) {
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
                    Navigator.of(context)
                        .popUntil(ModalRoute.withName("routeName"));
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
