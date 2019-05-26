import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:health_app/ui/exListScreen.dart';
import 'package:health_app/ui/menu_group.dart';
import 'package:health_app/ui/simple_bar_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:percent_indicator/percent_indicator.dart';
// import 'package:progress_indicators/progress_indicators.dart';

List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
  const StaggeredTile.count(6, 7),
  const StaggeredTile.count(6, 2),
  const StaggeredTile.count(3, 2),
  // const StaggeredTile.count(2, 2),
  // const StaggeredTile.count(2, 2),
];

bool loading = false;
List<Map<String, dynamic>> _listFood = [];
List<QuarterSales> mockedData = [
  QuarterSales('a1', 91),
  QuarterSales('a2', 31),
  QuarterSales('a3', 51),
  QuarterSales('a4', 71),
];

List<double> last7day = [0, 0, 0, 0, 0, 0, 0];
List<int> day_in_7 = [0, 0, 0, 0, 0, 0, 0];

class ExecisePage extends StatefulWidget {
  String string;
  ExecisePage(user);

  

  @override
  State<StatefulWidget> createState() {
    return ExecisePageState();
  }
}

class ExecisePageState extends State<ExecisePage> {

  
  var url =
      "https://raw.githubusercontent.com/benning55/exercise/master/db.json?fbclid=IwAR2ciBvMxgSOJ9_IPBNVEPfOZAEeYhhAncRaGmvzef92clHLzn6XRQxUB6Q";

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  fetchData() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Exercise',
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
              Tile1(),
              const _Example01Tile(Text("Exercise List"),
                  AssetImage('assets/images/icon/2.png')),
            ],
            mainAxisSpacing: 0.0,
            crossAxisSpacing: 0.0,
            padding: const EdgeInsets.all(5.0),
          ),
        ),
      ),
    );
  }
}

class Tile1 extends StatelessWidget {
  // Tile1(this._listFood, this.today, this.bmr);
  // double today;
  // String bmr;
  // List<Map<String, dynamic>> _listFood;

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
    return new Card(
      color: Colors.white,
      child: Container(
        margin: const EdgeInsets.all(20.0),
        constraints: BoxConstraints(minWidth: 100.0, minHeight: 150.0),
        child: Column(
          children: <Widget>[
            new Row(
              children: <Widget>[Text('Execise')],
            ),
            Container(
              alignment: Alignment.center,
              constraints: BoxConstraints(minWidth: 100.0, minHeight: 100.0),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text(
                      "mock",
                      style: TextStyle(fontSize: 50),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    child: Text('Mock',
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center),
                  ),
                ],
              ),
            ),
            Text("Mock"),
            Container(
              height: 200,
              child: SimpleBarChart(mapChartData(mockedData)),
            ),
            // Container(
            //       alignment: Alignment.center,
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: <Widget>[
            //           new LinearPercentIndicator(
            //             width: MediaQuery.of(context).size.width - 160,
            //             animation: true,
            //             lineHeight: 20.0,
            //             animationDuration: 1000,
            //             // percent: percent,
            //             // linearStrokeCap: LinearStrokeCap.roundAll,
            //             progressColor: Colors.green,
            //           ),
            //         ],
            //       ),
            //     ),
            //     Container(
            //       height: 200,
            //       // child: SimpleBarChart(mapChartData(mockedData)),
            //     ),
          ],
        ),
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Exercise()));
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