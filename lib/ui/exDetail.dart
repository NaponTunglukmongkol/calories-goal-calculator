import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_app/model/workOut.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

String type;
int cal;
int minute;

class ExerciseDetail extends StatefulWidget {
  Workout workout;
  ExerciseDetail(this.workout);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ExerciseDetailState(workout);
  }
}

class ExerciseDetailState extends State<ExerciseDetail> {
  String user = '';
  Workout workout;
  ExerciseDetailState(this.workout);

  String title;

  Future<String> getLogin() async {
    final prefs = await SharedPreferences.getInstance();
    this.user = prefs.get('user') ?? '0';
  }

  @override
  void initState() {
    type = workout.type;
    cal = workout.cal;
    minute = workout.minute;
    super.initState();
  }

  int minute_now = 0;
  int cal_burn = 0;

  Duration _duration = Duration(hours: 0, minutes: 0);

  @override
  Widget build(BuildContext context) {
    getLogin();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Add Exercise"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFF3366FF), Color(0xFF00CCFF)],
            ),
          ),
        ),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 80),
              child: Text(
                type,
                style: TextStyle(fontSize: 40.0),
                textAlign: TextAlign.center,
              ),
            ),
            Text("~ " + cal_burn.toString() + " cal" + " 🔥",
                style: TextStyle(fontSize: 20.0)),
            Text("~ " + minute_now.toString() + " minutes" + " 🕒",
                style: TextStyle(fontSize: 20.0)),
            new Expanded(
                child: DurationPicker(
              duration: _duration,
              onChange: (val) {
                this.setState(() => _duration = val);
                minute_now = _duration.inMinutes;
                cal_burn = minute_now * cal;
              },
            )),
            Container(
              margin: EdgeInsets.only(bottom: 50),
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
                        .collection('all_exercise_add')
                        .document();
                    await reference.setData({
                      "exerciseName": type,
                      "duration": minute_now,
                      "cal": cal_burn,
                      'hours': DateTime.now().hour,
                      'minute': DateTime.now().minute,
                      'day': DateTime.now().day,
                      'month': DateTime.now().month,
                      'year': DateTime.now().year,
                      'timestamp': DateTime.now(),
                    });
                  });
                  Navigator.of(context)
                      .popUntil(ModalRoute.withName("routeName"));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
