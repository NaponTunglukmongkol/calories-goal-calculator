import 'package:flutter/material.dart';
import 'package:health_app/ui/ButtonGradient.dart';
import 'package:health_app/ui/SignUp.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:health_app/ui/alert_ok.dart';

class RegisSecond extends StatefulWidget {
  Map dataRegis = new Map();
  RegisSecond(this.dataRegis);

  @override
  State<StatefulWidget> createState() {
    return RegisSecondState(dataRegis);
  }
}

class RegisSecondState extends State<RegisSecond> {
  final _formkey = GlobalKey<FormState>();
  Map dataRegis = new Map();

  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController txt = new TextEditingController();

  RegisSecondState(this.dataRegis);

  String _gen = "";
  String _datetime = '';
  int _year;
  int _month;
  int _date;

  String _lang = 'i18n';
  String _format = 'yyyy-mm-dd';

  String dob = "";
  int age;
  double bmr;

  bool _showTitleActions = true;
  void _handleRadioValueChange1(String value) {
    setState(() {
      _gen = value;
      print(_gen);
    });
  }

  void _showDatePicker() {
    DatePicker.showDatePicker(
      context,
      showTitleActions: _showTitleActions,
      minYear: 1950,
      maxYear: 2020,
      initialYear: _year,
      initialMonth: _month,
      initialDate: _date,
      confirm: Text(
        'Select',
        style: TextStyle(color: Colors.red),
      ),
      cancel: Text(
        'Cancel',
        style: TextStyle(color: Colors.cyan),
      ),
      locale: _lang,
      dateFormat: _format,
      onChanged: (year, month, date) {},
      onConfirm: (year, month, date) {
        _date = date;
        _year = year;
        _month = month;
        if (_month < 10) {
          if (_date < 10) {
            dob = "$_year-0$_month-0$_date";
          } else {
            dob = "$_year-0$_month-$_date";
          }
        } else {
          if (_date < 10) {
            dob = "$_year-$_month-0$_date";
          } else {
            dob = "$_year-$_month-$_date";
          }
        }

        txt.text = _date.toString() +
            " - " +
            _month.toString() +
            " - " +
            _year.toString();
        age = ((DateTime.now().difference(DateTime.parse(dob)).inDays) / 365)
            .round();
        print(age);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _formkey,
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: EdgeInsets.only(top: 0, left: 18, right: 18, bottom: 0),
              child: Column(
                children: <Widget>[
                  Text(
                    "Input your Information",
                    style: TextStyle(fontSize: 30),
                  ),
                  Container(
                      padding: EdgeInsets.all(8.0),
                      child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Radio(
                                  value: 'Male',
                                  groupValue: _gen,
                                  onChanged: _handleRadioValueChange1,
                                ),
                                new Text(
                                  'Male',
                                  style: new TextStyle(fontSize: 16.0),
                                ),
                                new Radio(
                                  value: 'Female',
                                  groupValue: _gen,
                                  onChanged: _handleRadioValueChange1,
                                ),
                                new Text(
                                  'Female',
                                  style: new TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ])),
                  Container(
                    padding: EdgeInsets.only(left: 40, right: 40, bottom: 30),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(0),
                          child: TextFormField(
                            controller: txt,
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    icon: Icon(Icons.date_range),
                                    onPressed: () {
                                      setState(() {
                                        _showDatePicker();
                                        txt.text = "";
                                        print(txt);
                                      });
                                    }),
                                labelText: "Date Of Birth"),
                          ),
                        ),
                        Container(
                            child: new Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                              new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: 100,
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: heightController,
                                      decoration:
                                          InputDecoration(labelText: 'Height'),
                                      validator: (value) {
                                        if (value.isEmpty) return "Height";
                                      },
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: weightController,
                                      decoration:
                                          InputDecoration(labelText: 'Weight'),
                                      validator: (value) {
                                        if (value.isEmpty) return "Weight";
                                      },
                                    ),
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
                          width: 100,
                          child: Text(
                            'Next',
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
                            if (_formkey.currentState.validate()) {
                              if (_gen.length == 0) {
                                alert_box("You have not selected Gender",
                                    "Please selected your Gender", context);
                              } else if (dob.length == 0) {
                                alert_box("You have not selected your Birthday",
                                    "Please selected your Birthday", context);
                              } else if (double.parse(weightController.text) <
                                      10 ||
                                  double.parse(weightController.text) > 300) {
                                alert_box(
                                    "Weight is not Collect",
                                    "Try again to input your weight again",
                                    context);
                              } else if (double.parse(heightController.text) <
                                      50 ||
                                  double.parse(heightController.text) > 300) {
                                alert_box(
                                    "Height is not Collect",
                                    "Try again to input your Height again",
                                    context);
                              } else {
                                if (_gen.toString() == 'Male') {
                                  bmr = 10 *
                                          double.parse(weightController.text) +
                                      6.25 *
                                          double.parse(heightController.text) -
                                      5 * age +
                                      5;
                                } else {
                                  bmr = 10 *
                                          double.parse(weightController.text) +
                                      6.25 *
                                          double.parse(heightController.text) -
                                      5 * age -
                                      161;
                                }
                                print(bmr.toString());
                                dataRegis['dob'] = dob;
                                dataRegis['age'] = age;
                                dataRegis['gen'] = _gen;
                                dataRegis['height'] = heightController.text;
                                dataRegis['weight'] = weightController.text;
                                dataRegis['bmr'] = bmr.toString();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RegisterScreen(dataRegis)));
                              }
                            }
                          }),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
