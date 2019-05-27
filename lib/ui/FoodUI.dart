import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:health_app/ui/detailFood.dart';
import 'package:health_app/ui/menu_group.dart';
import 'package:health_app/ui/simple_bar_chart.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:charts_flutter/flutter.dart' as charts;

List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
  const StaggeredTile.fit(6),
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(2, 2),
  const StaggeredTile.fit(6),
];

bool loading = false;
List<Map<String, dynamic>> _listFood = [];
List<QuarterSales> mockedData = [];

List<double> last7day = [0, 0, 0, 0, 0, 0, 0];
List<int> day_in_7 = [0, 0, 0, 0, 0, 0, 0];

class FoodPage extends StatefulWidget {
  String user, bmr;
  FoodPage(this.user, this.bmr);
  @override
  FoodPageState createState() => FoodPageState(user, bmr);
}

class FoodPageState extends State<FoodPage> {
  String user, bmr;
  FoodPageState(this.user, this.bmr);

  @override
  Widget build(BuildContext context) {
    // listFoodToday.clear();
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('users')
          .document(user)
          .collection('all_food_add')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    List<Widget> listFoodToday = [
      Container(
        color: Colors.blueAccent,
        child: ListTile(
          title: Text(
            "Eaten in Today",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          trailing: Text("Time", style: TextStyle(color: Colors.white)),
        ),
      )
    ];
    _listFood.clear();
    day_in_7 = [0, 0, 0, 0, 0, 0, 0];
    last7day = [0, 0, 0, 0, 0, 0, 0];
    if (_listFood.length < snapshot.length) {
      for (int i = 0; i < snapshot.length; i++) {
        _listFood.add({
          "cal": snapshot[i].data["cal"].toString(),
          "day": snapshot[i].data["day"].toString(),
          "hours": snapshot[i].data["hours"].toString(),
          "minute": snapshot[i].data["minute"].toString(),
          "month": snapshot[i].data["month"].toString(),
          "name": snapshot[i].data["name"].toString(),
          "unit": snapshot[i].data["unit"].toString(),
          "year": snapshot[i].data["year"].toString()
        });
        if (snapshot[i].data['day'].toString() ==
                DateTime.now().day.toString() &&
            snapshot[i].data['month'].toString() ==
                DateTime.now().month.toString()) {
          listFoodToday.add(new ListTile(
            subtitle: Text(snapshot[i].data["cal"].toString()),
            title: Text(snapshot[i].data["name"].toString()),
            trailing: Text(snapshot[i].data["hours"].toString() +
                ':' +
                snapshot[i].data["minute"].toString()),
          ));
        }

        for (int x = 0; x < 7; x++) {
          DateTime date = DateTime.now();
          day_in_7[x] = date.subtract(Duration(days: x)).day;
          if (date.subtract(Duration(days: x)).day == snapshot[i].data["day"]) {
            print(snapshot[i].data["name"].toString() +
                ' ' +
                snapshot[i].data["day"].toString() +
                ' ' +
                snapshot[i].data["cal"].toString());
            last7day[x] += double.parse(snapshot[i].data["cal"].toString());
          }
        }
      }

      day_in_7 = day_in_7.reversed.toList();
      last7day = last7day.reversed.toList();
      print(day_in_7);
      print(last7day);
      for (int d = 0; d < day_in_7.length; d++) {
        mockedData.add(QuarterSales(day_in_7[d].toString(), last7day[d]));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Food',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
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
      body: Container(
          color: Colors.blueGrey,
          child: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: new StaggeredGridView.count(
                crossAxisCount: 6,
                staggeredTiles: _staggeredTiles,
                children: <Widget>[
                  Tile1(_listFood, last7day[6], bmr),
                  const _Example01Tile(Text("Breakfast"),
                      AssetImage('assets/images/icon/salad.png')),
                  const _Example01Tile(
                      Text("Lunch"), AssetImage('assets/images/icon/sea.png')),
                  const _Example01Tile(Text("Dinner"),
                      AssetImage('assets/images/icon/steak.png')),
                  Tile_all_food(listFoodToday),
                ],
                mainAxisSpacing: 0.0,
                crossAxisSpacing: 0.0,
                padding: const EdgeInsets.all(5.0),
              ))),
    );
  }
}

class Tile1 extends StatelessWidget {
  Tile1(this._listFood, this.today, this.bmr);
  double today;
  String bmr;
  List<Map<String, dynamic>> _listFood;

  /// Create one series with pass in data.
  List<charts.Series<QuarterSales, String>> mapChartData(
      List<QuarterSales> data) {
    return [
      charts.Series<QuarterSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.cyan.shadeDefault,
        domainFn: (QuarterSales sales, _) => sales.quarter,
        measureFn: (QuarterSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    double percent = (today / double.parse(bmr));
    print(percent);
    if (percent > 1) {
      percent = 1.0;
    }
    print(percent);
    return new Card(
      color: Colors.white,
      child: new InkWell(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.all(20.0),
            constraints: BoxConstraints(minWidth: 100.0, minHeight: 150.0),
            child: Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[Text("cal Food")],
                ),
                Container(
                    alignment: Alignment.center,
                    constraints:
                        BoxConstraints(minWidth: 100.0, minHeight: 100.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Text(today.round().toString(),
                              style: TextStyle(fontSize: 50),
                              textAlign: TextAlign.center),
                        ),
                        Container(
                          child: Text('/$bmr cal',
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.center),
                        ),
                      ],
                    )),
                Text((percent * 100).toString() + ' %'),
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new LinearPercentIndicator(
                        width: MediaQuery.of(context).size.width - 160,
                        animation: true,
                        lineHeight: 20.0,
                        animationDuration: 1000,
                        percent: percent,
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: Colors.green,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 200,
                  child: SimpleBarChart(mapChartData(mockedData)),
                ),
              ],
            ),
          )),
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
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MenuBook()));
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

class Tile_all_food extends StatelessWidget {
  Tile_all_food(this._listFoodToday);
  List<Widget> _listFoodToday;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        child: new InkWell(
            onTap: () {
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => MenuBook()));
            },
            child: Column(
              children: _listFoodToday,
            )));
  }
}
