import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:health_app/ui/simple_bar_chart.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final mockedData = [
    QuarterSales('Q1', 50000),
    QuarterSales('Q2', 25000),
    QuarterSales('Q3', 100000),
    QuarterSales('Q4', 75000),
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
    return Scaffold(
      body: Container(
        child: SimpleBarChart(mapChartData(mockedData)),
      ),
    );
  }
}
