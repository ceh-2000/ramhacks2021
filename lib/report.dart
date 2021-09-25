import 'package:flutter/material.dart';

import 'constants.dart';

class Report extends StatefulWidget {
  @override
  _Report createState() => _Report();
}

class _Report extends State<Report> {
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
                            children: <Widget>[Text('Report')]))))));
  }
}
