import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'flow_data.dart';

class Report extends StatefulWidget {
  @override
  _Report createState() => _Report();
}

class _Report extends State<Report> {
  num AVG_COST_PER_TAMPON = 0.57; // Source: Tampax brand tampons

  String _periodStartDate = 'Sep 23';
  String _periodEndDate = 'Sep 26';
  num _sumTampons = 0;
  num _numDaysInCycle = 0;
  num _periodHeaviestDay = 0;
  num _tamponsUsedAverage = 0;

  void populateValues(all_the_data) {
    Map<String, String> months = {
      '1': 'Jan',
      '2': 'Feb',
      '3': 'Mar',
      '4': 'Apr',
      '5': 'May',
      '6': 'Jun',
      '7': 'Jul',
      '8': 'Aug',
      '9': 'Sep',
      '10': 'Oct',
      '11': 'Nov',
      '12': 'Dec'
    };

    if (all_the_data.length > 0) {
      DateTime endDate = all_the_data[all_the_data.length - 1].date_time;

      _periodEndDate = months[endDate.month.toString()].toString() +
          ' ' +
          endDate.day.toString();

      List<FlowData> dates = [];

      _numDaysInCycle = 0;
      _sumTampons = 0;

      for (int i = all_the_data.length - 1; i >= 0; i--) {
        _sumTampons += all_the_data[i].count;
        _numDaysInCycle += 1;

        if(all_the_data[i].count > _periodHeaviestDay){
          _periodHeaviestDay = all_the_data[i].count;
        }

        if (i < all_the_data.length - 1) {
          DateTime curDate = all_the_data[i].date_time;
          DateTime prevDate = all_the_data[i + 1].date_time;


          if (curDate.difference(prevDate).inDays > 1) {
            break;
          } else {
            dates.add(all_the_data[i]);
          }
        }
      }

      DateTime startDate = dates[dates.length - 1].date_time;
      _numDaysInCycle = dates.length;
      _periodStartDate = months[startDate.month.toString()].toString() +
          ' ' +
          startDate.day.toString();

      _tamponsUsedAverage = (_sumTampons / _numDaysInCycle).floor();
    }
  }

  Widget buildBody() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(children: <Widget>[
            Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: Constants.color1,
                    border: Border.all(
                      color: Constants.color1,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Text('Sep 23',
                    style: TextStyle(
                        color: Constants.white,
                        fontSize: Constants.mediumFont))),
            SizedBox(width: Constants.spacer),
            Flexible(
                child: Text('is when your last period started.',
                    style: TextStyle(fontSize: Constants.smallFont)))
          ]),
          SizedBox(height: Constants.spacer),
          Row(children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    color: Constants.color1,
                    border: Border.all(
                      color: Constants.color1,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                padding: EdgeInsets.all(10.0),
                child: Text(_periodEndDate,
                    style: TextStyle(
                        color: Constants.white,
                        fontSize: Constants.mediumFont))),
            SizedBox(width: Constants.spacer),
            Flexible(
                child: Text('is when your last period ended.',
                    style: TextStyle(fontSize: Constants.smallFont)))
          ]),
          SizedBox(height: Constants.spacer),
          Row(children: <Widget>[
            Text('Your period lasted',
                    style: TextStyle(fontSize: Constants.smallFont)),
            SizedBox(width: Constants.spacer),
            Container(
                decoration: BoxDecoration(
                    color: Constants.color1,
                    border: Border.all(
                      color: Constants.color1,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                padding: EdgeInsets.all(10.0),
                child: Text(_numDaysInCycle.toString(),
                    style: TextStyle(
                        color: Constants.white,
                        fontSize: Constants.mediumFont))),
            SizedBox(width: Constants.spacer),
            Flexible(
                child: Text('days.',
                    style: TextStyle(fontSize: Constants.smallFont)))
          ]),
          SizedBox(height: Constants.spacer),
          Row(children: <Widget>[
            Flexible(
                child: Text('You used',
                    style: TextStyle(fontSize: Constants.smallFont))),
            SizedBox(width: Constants.spacer),
            Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: Constants.color1,
                    border: Border.all(
                      color: Constants.color1,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Text(_periodHeaviestDay.toString(),
                    style: TextStyle(
                        color: Constants.white,
                        fontSize: Constants.mediumFont))),
            SizedBox(width: Constants.spacer),
            Text('on your heaviest day.',
                style: TextStyle(fontSize: Constants.smallFont))
          ]),
          SizedBox(height: Constants.spacer),
          Row(children: <Widget>[
            Flexible(
                child: Text('You used',
                    style: TextStyle(fontSize: Constants.smallFont))),
            SizedBox(width: Constants.spacer),
            Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: Constants.color1,
                    border: Border.all(
                      color: Constants.color1,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Text(_tamponsUsedAverage.toString(),
                    style: TextStyle(
                        color: Constants.white,
                        fontSize: Constants.mediumFont))),
            SizedBox(width: Constants.spacer),
            Text('on average per day.',
                style: TextStyle(fontSize: Constants.smallFont))
          ]),
          SizedBox(height: Constants.spacer),
          Row(children: <Widget>[
            Text('You spent',
                    style: TextStyle(fontSize: Constants.smallFont)),
            SizedBox(width: Constants.spacer),
            Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: Constants.color1,
                    border: Border.all(
                      color: Constants.color1,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Text('\~\$'+(num.parse((_sumTampons*AVG_COST_PER_TAMPON).toStringAsFixed(2))).toString(),
                    style: TextStyle(
                        color: Constants.white,
                        fontSize: Constants.mediumFont))),
            SizedBox(width: Constants.spacer),
            Text('on tampons.',
                style: TextStyle(fontSize: Constants.smallFont))
          ]),
          SizedBox(height: Constants.spacer),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            backgroundColor: Constants.background2,
            appBar: AppBar(
              title: const Text('Report'),
            ),
            body: SafeArea(
                child: Center(
                    child: Container(
                        margin: const EdgeInsets.all(20.0),
                        child: StreamBuilder(
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
                              List<dynamic> results = snapshot.data?.docs ?? [];

                              // Produce list of date and times
                              List<FlowData> flowData =
                                  produceListOfFlowData(results);

                              populateValues(flowData);

                              return buildBody();
                            }))))));
  }
}
