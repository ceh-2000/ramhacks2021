import 'package:flutter/material.dart';

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
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('DataVis'),
          ),
          body: const Padding(
              padding: EdgeInsets.all(50.0), child: Text('DataVis')),
        ));
  }
}