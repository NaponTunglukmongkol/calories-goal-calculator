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
List<Map<String, String>> _listFood = [];

List<Widget> listFoodToday = [
  Container(
    color: Colors.blueAccent,
    child: ListTile(
      title: Text(
        "Eaten in Today",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: Text("Time"),
    ),
  )
];

class FoodPage extends StatefulWidget {
  String user;
  FoodPage(this.user);
  @override
  FoodPageState createState() => FoodPageState(user);
}

class FoodPageState extends State<FoodPage> {
  String user;
  FoodPageState(this.user);

  @override
  Widget build(BuildContext context) {
    listFoodToday.clear();
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
                  Tile1(_listFood),
                  const _Example01Tile(Text("Breakfast"),
                      AssetImage('assets/images/icon/1.png')),
                  const _Example01Tile(
                      Text("Lunch"), AssetImage('assets/images/icon/2.png')),
                  const _Example01Tile(
                      Text("Dinner"), AssetImage('assets/images/icon/3.png')),
                  Tile_all_food(_listFood),
                ],
                mainAxisSpacing: 0.0,
                crossAxisSpacing: 0.0,
                padding: const EdgeInsets.all(5.0),
              ))),
    );
  }
}

class Tile1 extends StatelessWidget {
  Tile1(this._listFood);
  List<Map<String, String>> _listFood;
  final mockedData = [
    QuarterSales('Q1', 9),
    QuarterSales('Q2', 9),
    QuarterSales('Q3', 10),
    QuarterSales('Q4', 7),
  ];

  /// Create one series with pass in data.
  List<charts.Series<QuarterSales, String>> mapChartData(
      List<QuarterSales> data) {
    return [
      charts.Series<QuarterSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.indigo.shadeDefault,
        domainFn: (QuarterSales sales, _) => sales.quarter,
        measureFn: (QuarterSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    print(_listFood);
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
                          child: Text("1000",
                              style: TextStyle(fontSize: 50),
                              textAlign: TextAlign.center),
                        ),
                        Container(
                          child: Text("/1000 cal",
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.center),
                        ),
                      ],
                    )),
                Text("80.0%"),
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
                        percent: 0.8,
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
  Tile_all_food(this._listFood);
  List<Map<String, String>> _listFood;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
        color: Colors.white,
        child: new InkWell(
            onTap: () {
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => MenuBook()));
            },
            child: Column(
              children: listFoodToday,
            )));
  }
}
