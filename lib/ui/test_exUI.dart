import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:health_app/model/workOut.dart';
// import 'package:health_app/ui/list_food.dart';
// import './image_pick.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'exDetail.dart';

var data;

List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
  const StaggeredTile.count(3, 2),
  const StaggeredTile.count(3, 2),
  const StaggeredTile.count(3, 2),
  const StaggeredTile.count(3, 2),
  const StaggeredTile.count(3, 2),
  const StaggeredTile.count(3, 2),
  const StaggeredTile.count(3, 2),
  const StaggeredTile.count(3, 2),
  const StaggeredTile.count(3, 2),
  const StaggeredTile.count(3, 2),
  const StaggeredTile.count(3, 2),
  const StaggeredTile.count(3, 2),
  const StaggeredTile.count(3, 2),
  const StaggeredTile.count(3, 2),
  const StaggeredTile.count(3, 2),
  const StaggeredTile.count(3, 2),
  const StaggeredTile.count(3, 2),
];
List<Widget> _tiles = <Widget>[
  TileFood(
      Text("Running"),
      AssetImage('assets/images/icon/running.png'),
      Workout.setValue(
          data[0]['id'], data[0]['type'], data[0]['minutes'], data[0]['cal'])),
  TileFood(
      Text("Rope Jumping"),
      AssetImage('assets/images/icon/jumping-rope.png'),
      Workout.setValue(
          data[1]['id'], data[1]['type'], data[1]['minutes'], data[1]['cal'])),
  TileFood(
      Text("Basketball"),
      AssetImage('assets/images/icon/basketball.png'),
      Workout.setValue(
          data[4]['id'], data[4]['type'], data[4]['minutes'], data[4]['cal'])),
  TileFood(
      Text("Bowling"),
      AssetImage('assets/images/icon/bowling.png'),
      Workout.setValue(data[10]['id'], data[10]['type'], data[10]['minutes'],
          data[10]['cal'])),
  TileFood(
      Text("Cycling"),
      AssetImage('assets/images/icon/cycling.png'),
      Workout.setValue(
          data[5]['id'], data[5]['type'], data[5]['minutes'], data[5]['cal'])),
  TileFood(
      Text("Football"),
      AssetImage('assets/images/icon/football.png'),
      Workout.setValue(
          data[7]['id'], data[7]['type'], data[7]['minutes'], data[7]['cal'])),
  TileFood(
      Text("Golf"),
      AssetImage('assets/images/icon/golf.png'),
      Workout.setValue(data[13]['id'], data[13]['type'], data[13]['minutes'],
          data[13]['cal'])),
  TileFood(
      Text("Table Tennis"),
      AssetImage('assets/images/icon/ping-pong.png'),
      Workout.setValue(
          data[9]['id'], data[9]['type'], data[9]['minutes'], data[9]['cal'])),
  TileFood(
      Text("Swimming"),
      AssetImage('assets/images/icon/swimming-pool.png'),
      Workout.setValue(
          data[2]['id'], data[2]['type'], data[2]['minutes'], data[2]['cal'])),
  TileFood(
      Text("Volleyball"),
      AssetImage('assets/images/icon/volleyball.png'),
      Workout.setValue(data[11]['id'], data[11]['type'], data[11]['minutes'],
          data[11]['cal'])),
  TileFood(
      Text("Boxing"),
      AssetImage('assets/images/icon/boxing.png'),
      Workout.setValue(
          data[6]['id'], data[6]['type'], data[6]['minutes'], data[6]['cal'])),
  TileFood(
      Text("Climbling"),
      AssetImage('assets/images/icon/climbing.png'),
      Workout.setValue(data[15]['id'], data[15]['type'], data[15]['minutes'],
          data[15]['cal'])),
  TileFood(
      Text("Martial Arts"),
      AssetImage('assets/images/icon/karate.png'),
      Workout.setValue(data[17]['id'], data[17]['type'], data[17]['minutes'],
          data[17]['cal'])),
  TileFood(
      Text("Tennis"),
      AssetImage('assets/images/icon/tennis.png'),
      Workout.setValue(
          data[8]['id'], data[8]['type'], data[8]['minutes'], data[8]['cal'])),
  TileFood(
      Text("Walk"),
      AssetImage('assets/images/icon/walking.png'),
      Workout.setValue(data[12]['id'], data[12]['type'], data[12]['minutes'],
          data[12]['cal'])),
  TileFood(
      Text("Yoga"),
      AssetImage('assets/images/icon/meditation.png'),
      Workout.setValue(data[14]['id'], data[14]['type'], data[14]['minutes'],
          data[14]['cal'])),
];

class ExerciseList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ExerciseState();
  }
}

class ExerciseState extends State<ExerciseList> {
  String url =
      'https://raw.githubusercontent.com/benning55/exercise/master/db.json';
  Future<String> makeRequest() async {
    var response = await http.get(Uri.encodeFull(url));
    setState(() {
      data = json.decode(response.body).cast<Map<String, dynamic>>();
    });
  }

  @override
  void initState() {
    this.makeRequest();
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Exercise you might interest'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Exercise you might interest'),
        ),
        body: Container(
          color: Colors.blueGrey,
          child: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: StaggeredGridView.count(
                crossAxisCount: 6,
                staggeredTiles: _staggeredTiles,
                children: _tiles,
                mainAxisSpacing: 0.0,
                crossAxisSpacing: 0.0,
                padding: const EdgeInsets.all(5.0),
              )),
        ),
      );
    }
  }
}

class TileFood extends StatelessWidget {
  TileFood(this.text, this.icon, this.workout);

  final Text text;
  final AssetImage icon;
  final Workout workout;

  @override
  Widget build(BuildContext context) {
    return new Card(
        color: Colors.white,
        child: new InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ExerciseDetail(workout)));
            },
            child: Center(
              child: new Container(
                height: 96,
                child: new Column(
                  children: <Widget>[Image(image: icon, width: 80.0), text],
                ),
              ),
            )));
  }
}
