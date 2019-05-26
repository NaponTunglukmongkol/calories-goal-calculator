import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
// import 'package:percent_indicator/percent_indicator.dart';
// import 'package:progress_indicators/progress_indicators.dart';

List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
  const StaggeredTile.count(6, 2),
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(6, 2),
];

class ExecisePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ExecisePageState();
  }
}

class ExecisePageState extends State<ExecisePage> {
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
              Tile1(),
              Tile1(),
              Tile1(),
              Tile1(),
              Tile1(),
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
