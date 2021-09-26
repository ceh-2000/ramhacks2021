import 'package:flutter/material.dart';

import 'constants.dart';

class Report extends StatefulWidget {
  @override
  _Report createState() => _Report();
}

class _Report extends State<Report> {
  String _periodStartDate = 'Sep 23';
  String _periodEndDate = 'Sep 26';
  int _periodHeaviestDay = 0;
  int _tamponsUsedAverage = 0;

  @override
  void initState() {}

  _Report() {}

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
                        child: Column(
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Text('Sep 23',
                                        style: TextStyle(
                                            color: Constants.white,
                                            fontSize: Constants.mediumFont))),
                                SizedBox(width: Constants.spacer),
                                Flexible(
                                    child: Text(
                                        'is when your last period started.',
                                        style: TextStyle(
                                            fontSize: Constants.smallFont)))
                              ]),
                              SizedBox(height: Constants.spacer),
                              Row(children: <Widget>[
                                Container(
                                    decoration: BoxDecoration(
                                        color: Constants.color1,
                                        border: Border.all(
                                          color: Constants.color1,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    padding: EdgeInsets.all(10.0),
                                    child: Text('Sep 26',
                                        style: TextStyle(
                                            color: Constants.white,
                                            fontSize: Constants.mediumFont))),
                                SizedBox(width: Constants.spacer),
                                Flexible(
                                    child: Text(
                                        'is when your last period ended.',
                                        style: TextStyle(
                                            fontSize: Constants.smallFont)))
                              ]),
                              SizedBox(height: Constants.spacer),
                              Row(children: <Widget>[
                                Flexible(
                                    child: Text('You used',
                                        style: TextStyle(
                                            fontSize: Constants.smallFont))),
                                SizedBox(width: Constants.spacer),
                                Container(
                                    padding: EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                        color: Constants.color1,
                                        border: Border.all(
                                          color: Constants.color1,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Text('5',
                                        style: TextStyle(
                                            color: Constants.white,
                                            fontSize: Constants.mediumFont))),
                                SizedBox(width: Constants.spacer),
                                Text('on your heaviest day.',
                                        style: TextStyle(
                                            fontSize: Constants.smallFont))
                              ]),
                              SizedBox(height: Constants.spacer),
                              Row(children: <Widget>[
                                Flexible(
                                    child: Text('You used',
                                        style: TextStyle(
                                            fontSize: Constants.smallFont))),
                                SizedBox(width: Constants.spacer),
                                Container(
                                    padding: EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                        color: Constants.color1,
                                        border: Border.all(
                                          color: Constants.color1,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Text('3',
                                        style: TextStyle(
                                            color: Constants.white,
                                            fontSize: Constants.mediumFont))),
                                SizedBox(width: Constants.spacer),
                                Text('on average per day.',
                                        style: TextStyle(
                                            fontSize: Constants.smallFont))
                              ]),
                              SizedBox(height: Constants.spacer),
                            ]))))));
  }
}
