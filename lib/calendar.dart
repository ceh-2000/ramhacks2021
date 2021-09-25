import 'package:flutter/material.dart';

class Calendar extends StatefulWidget {
  @override
  _Calendar createState() => _Calendar();
}

class _Calendar extends State<Calendar> {
  @override
  void initState() {}

  _Calendar() {}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Calendar'),
          ),
          body: const Padding(
              padding: EdgeInsets.all(50.0), child: Text('Calendar')),
        ));
  }
}