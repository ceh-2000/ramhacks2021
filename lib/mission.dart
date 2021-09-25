import 'package:flutter/material.dart';

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
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Mission'),
          ),
          body: const Padding(
              padding: EdgeInsets.all(50.0), child: Text('Mission')),
        ));
  }
}