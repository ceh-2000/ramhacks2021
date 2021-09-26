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
  @override
  void initState() {}

  _DataVis() {}

  // Produce a list of flow data for the user (aggregated sums per day)
  List<FlowData> _produceListOfFlowData(var results){
    // We only care about the first user
    var userInfo = results[0];
    List<dynamic> buttonPresses = userInfo!['button_log'] ?? [];

    Map<DateTime, int> my_dates = {};
    Set<DateTime> the_dates = {};
    for(int j = 0; j < buttonPresses.length; j++){
      Timestamp timeStamp = buttonPresses[j];

      // We need to convert our seconds to a DateTime object
      DateTime my_date = DateTime.fromMillisecondsSinceEpoch(timeStamp.seconds * 1000);

      // Truncate the date to exclude time specifics
      DateTime truncated_date = new DateTime(my_date.year, my_date.month, my_date.day, 0,0,0,0,0);

      // If we already have the entry, add to it otherwise create a new one
      if(my_dates[truncated_date] == null){
        my_dates[truncated_date] = 1;
      }
      else{
        int cur_date = my_dates[truncated_date] ?? 0;
        my_dates[truncated_date] = cur_date + 1;
      }

      the_dates.add(truncated_date);
    }

    List<DateTime> another_date_list = the_dates.toList();
    another_date_list.sort();

    List<FlowData> flow_series_data = [];
    for(int k = 0; k < another_date_list.length; k++){
      print(another_date_list[k]);
      DateTime key = another_date_list[k];
      int value = my_dates[key] ?? 0;

      flow_series_data.add(FlowData(key, value));
    }

    return flow_series_data;
  }

  // Get the data to put into our series
  List<Series<FlowData, int>> _getSeriesData(data) {
    List<charts.Series<FlowData, int>> series = [
      charts.Series(
          id: 'Flow',
          data: data,
          domainFn: (FlowData series, _) => series.date_time.day,
          measureFn: (FlowData series, _) => series.count,
          colorFn: (FlowData series, _) =>
          charts.MaterialPalette.blue.shadeDefault),

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
                              // Expanded(
                              //   child: new charts.LineChart(
                              //     _getSeriesData(),
                              //     animate: true,
                              //   ),
                              // )
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
                                    List<FlowData> flowData = _produceListOfFlowData(results);

                                    return Expanded(
                                      child: new charts.LineChart(
                                        _getSeriesData(flowData),
                                        animate: true,
                                      ),
                                    );
                                  })
                            ]))))));
  }
}
