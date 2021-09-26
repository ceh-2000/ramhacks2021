import 'package:flutter/material.dart';

import 'constants.dart';

class Mission extends StatefulWidget {
  @override
  _Mission createState() => _Mission();
}

class _Mission extends State<Mission> {
  @override
  void initState() {}

  _Mission() {}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            backgroundColor: Constants.background2,
            appBar: AppBar(
              title: const Text('Mission'),
            ),
            body: SafeArea(
                child: Center(
                    child: Container(
                        margin: const EdgeInsets.all(20.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                  'Menstrual health is a heavily stigmatized topic, redirecting the focus from the real task at hand: ensuring folks are connected to resources that will make “that time of the month” just a little bit easier. We wanted to build one such resource: something that would automate the period tracking process, making it easier to stay on top of your periods cycle and report to your gynecologist of any irregularities.', textAlign: TextAlign.justify, style: TextStyle(fontSize: 22)),
                              SizedBox(height: Constants.spacer),
                              ElevatedButton(
                                  onPressed: () {
                                    // TODO: Call Pablo's function

                                  },
                                  child: Text('Dispense Tampon', style: TextStyle(fontSize: Constants.mediumFont)))
                            ]))))));
  }
}
