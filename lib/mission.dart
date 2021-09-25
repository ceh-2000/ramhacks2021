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
                            children: <Widget>[Text('Mission')]))))));
  }
}
