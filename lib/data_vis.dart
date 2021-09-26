import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:charts_flutter/flutter.dart' as charts;

import 'constants.dart';
import 'flow_data.dart';

class DataVis extends StatefulWidget {
  @override
  _DataVis createState() => _DataVis();
}

class _DataVis extends State<DataVis> {
  // Get the data to put into our series
  List<Series<FlowData, DateTime>> _getSeriesData(data) {
    List<charts.Series<FlowData, DateTime>> series = [
      charts.Series(
          id: 'Flow',
          data: data,
          domainFn: (FlowData series, _) => series.date_time,
          measureFn: (FlowData series, _) => series.count,
          colorFn: (_, __) => charts.MaterialPalette.purple.shadeDefault,
    ),

    ];
    return series;
  }

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
                              StreamBuilder(
                                  // The stream is where we want to read from continuously
                                  stream: FirebaseFirestore.instance
                                      .collection(
                                          Constants.firebaseCollectionDevices)
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
                                    List<dynamic> results = snapshot.data?.docs ?? [];

                                    // Produce list of date and times
                                    List<FlowData> flowData = produceListOfFlowData(results);

                                    return Expanded(
                                      child: new charts.TimeSeriesChart(
                                        _getSeriesData(flowData),
                                        animate: true,
                                      ),
                                    );
                                  })
                            ]))))));
  }
}
