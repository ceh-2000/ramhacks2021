import 'package:flutter/material.dart';

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
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Report'),
          ),
          body: const Padding(
              padding: EdgeInsets.all(50.0), child: Text('Report')),
        ));
  }
}