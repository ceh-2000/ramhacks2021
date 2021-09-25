import 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;

import 'constants.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

// class PopulationData {
//   int year;
//   int population;
//   charts.Color barColor;
//   PopulationData({
//     required this.year,
//     required this.population,
//     required this.barColor
//   });
// }

class SalesData {
  final int year;
  final int sales;

  SalesData(this.year, this.sales);
}

final data = [
  new SalesData(0, 1500000),
  new SalesData(1, 1735000),
  new SalesData(2, 1678000),
  new SalesData(3, 1890000),
  new SalesData(4, 1907000),
  new SalesData(5, 2300000),
  new SalesData(6, 2360000),
  new SalesData(7, 1980000),
  new SalesData(8, 2654000),
  new SalesData(9, 2789070),
  new SalesData(10, 3020000),
  new SalesData(11, 3245900),
  new SalesData(12, 4098500),
  new SalesData(13, 4500000),
  new SalesData(14, 4456500),
  new SalesData(15, 3900500),
  new SalesData(16, 5123400),
  new SalesData(17, 5589000),
  new SalesData(18, 5940000),
  new SalesData(19, 6367000),
];

_getSeriesData() {
  List<charts.Series<SalesData, int>> series = [
    charts.Series(
        id: "Sales",
        data: data,
        domainFn: (SalesData series, _) => series.year,
        measureFn: (SalesData series, _) => series.sales,
        colorFn: (SalesData series, _) => charts.MaterialPalette.blue.shadeDefault
    )
  ];
  return series;
}

// late List<PopulationData> data = [
//   PopulationData(
//       year: 1880,
//       population: 50189209,
//       barColor: charts.ColorUtil.fromDartColor(Colors.lightBlue)
//   ),
//   PopulationData(
//       year: 1890,
//       population: 62979766,
//       barColor: charts.ColorUtil.fromDartColor(Colors.lightBlue)
//   ),
//   PopulationData(
//       year: 1900,
//       population: 76212168,
//       barColor: charts.ColorUtil.fromDartColor(Colors.lightBlue)
//   ),
//   PopulationData(
//       year: 1910,
//       population: 92228496,
//       barColor: charts.ColorUtil.fromDartColor(Colors.lightBlue)
//   ),
//   PopulationData(
//       year: 1920,
//       population: 106021537,
//       barColor: charts.ColorUtil.fromDartColor(Colors.blue)
//   ),
//   PopulationData(
//       year: 1930,
//       population: 123202624,
//       barColor: charts.ColorUtil.fromDartColor(Colors.blue)
//   ),
//   PopulationData(
//       year: 1940,
//       population: 132164569,
//       barColor: charts.ColorUtil.fromDartColor(Colors.blue)
//   ),
//   PopulationData(
//       year: 1950,
//       population: 151325798,
//       barColor: charts.ColorUtil.fromDartColor(Colors.blue)
//   ),
//   PopulationData(
//       year: 1960,
//       population: 179323175,
//       barColor: charts.ColorUtil.fromDartColor(Colors.blue)
//   ),
//   PopulationData(
//       year: 1970,
//       population: 203302031,
//       barColor: charts.ColorUtil.fromDartColor(Colors.purple)
//   ),
//   PopulationData(
//       year: 1980,
//       population: 226542199,
//       barColor: charts.ColorUtil.fromDartColor(Colors.purple)
//   ),
//   PopulationData(
//       year: 1990,
//       population: 248709873,
//       barColor: charts.ColorUtil.fromDartColor(Colors.purple)
//   ),
//   PopulationData(
//       year: 2000,
//       population: 281421906,
//       barColor: charts.ColorUtil.fromDartColor(Colors.purple)
//   ),
//   PopulationData(
//       year: 2010,
//       population: 307745538,
//       barColor: charts.ColorUtil.fromDartColor(Colors.black)
//   ),
//   PopulationData(
//       year: 2017,
//       population: 323148586,
//       barColor: charts.ColorUtil.fromDartColor(Colors.black)
//   ),
//
// ];

// _getSeriesData() {
//   List<charts.Series<PopulationData, String>> series = [
//     charts.Series(
//         id: "Population",
//         data: data,
//         domainFn: (PopulationData series, _) => series.year.toString(),
//         measureFn: (PopulationData series, _) => series.population,
//         colorFn: (PopulationData series, _) => series.barColor
//     )
//   ];
//   return series;
// }

class DataVis extends StatefulWidget {
  @override
  _DataVis createState() => _DataVis();
}

class _DataVis extends State<DataVis> {
  @override
  void initState() {}

  _DataVis() {}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            backgroundColor: Constants.background2,
            appBar: AppBar(
              title: const Text('Data Viz'),
            ),
            body: SafeArea(
                child: Center(
                    child: Container(
                        margin: const EdgeInsets.all(20.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              // Text(
                              //   "Population of U.S. over the years",
                              //   style: TextStyle(
                              //       fontWeight: FontWeight.bold
                              //   ),
                              // ),
                              // SizedBox(height: 20,),
                              // Expanded(
                              //   child: charts.BarChart(
                              //     _getSeriesData(),
                              //     animate: true,
                              //     domainAxis: charts.OrdinalAxisSpec(
                              //         renderSpec: charts.SmallTickRendererSpec(labelRotation: 60)
                              //     ),
                              //   ),
                              // )
                              StreamBuilder(
                              // The stream is where we want to read from continuously
                              stream: FirebaseFirestore.instance
                                  .collection(Constants.firebaseCollectionDevices)
                                  .snapshots(),
                              // The builder is what we do with the data from our stream
                              builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                                // We got no data yet so let's wait...
                                if (!snapshot.hasData) {
                                  return Center(
                                      child: SizedBox(
                                          width: 100,
                                          height: 100,
                                          child: CircularProgressIndicator(
                                              strokeWidth: 12,
                                              color: Constants.color2)));
                                }
                                return Expanded(
                                  child: new charts.LineChart(_getSeriesData(), animate: true,),
                                );
                              }
                              )]))))));
  }
}
