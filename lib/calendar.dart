import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'constants.dart';
import 'flow_data.dart';

class Calendar extends StatefulWidget {
  @override
  _Calendar createState() => _Calendar();
}

class _Calendar extends State<Calendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _firstDay = DateTime.utc(2010, 1, 1);
  DateTime _lastDay = DateTime.utc(2030, 1, 1);
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // List of Events
  late Map<DateTime, List<dynamic>> _events;

  @override
  void initState() {
    super.initState();

    // Read in all events ever from Firebase
    _events = {
      DateTime.utc(2021, 9, 20): ['tampon']
    };
  }

  List<dynamic> _getEventsForDay(day) {
    List<dynamic> v_emi = [];
    _events.forEach((k, v){
      if(day.toString().substring(0, day.toString().length-1) == k.toString()){
        v_emi = v;
      }
    });
    return v_emi ?? [];
  }

  Widget buildBody(){
    return Column(
      children: <Widget>[
        TableCalendar(
          firstDay: _firstDay,
          lastDay: _lastDay,
          calendarFormat: _calendarFormat,
          calendarStyle: const CalendarStyle(
            canMarkersOverflow: true,
            todayDecoration: BoxDecoration(
              color: Constants.color1,
              shape: BoxShape.circle,
            ),
            markersMaxCount: 10,
            markerSizeScale: 0.0,
            markerMargin: EdgeInsets.symmetric(
                horizontal: 5.0),
            markerDecoration: Icon(
              Icons.invert_colors,
              color: Colors.red,
              size: 15.0,
            ),
            markersAutoAligned: false,
            markersOffset: PositionedOffset(bottom: 20, start: 0),
            selectedDecoration: BoxDecoration(
              color: Constants.color1Dark,
              shape: BoxShape.circle,
            ),
          ),
          focusedDay: DateTime.now(),
          selectedDayPredicate: (day) {
            // Use `selectedDayPredicate` to determine which day is currently selected.
            return isSameDay(_selectedDay, day);
          },
          onDaySelected:
              (selectedDay, focusedDay) {
            if (!isSameDay(
                _selectedDay, selectedDay)) {
              // TODO: Add code to allow user to manually enter data about tampon use

              // Call `setState()` when updating the selected day
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            }
          },
          onFormatChanged: (format) {
            if (_calendarFormat != format) {
              // Call `setState()` when updating calendar format
              setState(() {
                _calendarFormat = format;
              });
            }
          },
          eventLoader: (day) {
            return _getEventsForDay(day);
          },
          onPageChanged: (focusedDay) {
            // No need to call `setState()` here
            _focusedDay = focusedDay;
          },
        ),
        const SizedBox(height: Constants.spacer),
        _getEventsForDay(_selectedDay).isNotEmpty
            ? Text(
            'Number of tampons: ' +
                _getEventsForDay(
                    _selectedDay)
                    .length
                    .toString(),
            style: const TextStyle(
                fontSize:
                Constants.mediumFont))
            : const SizedBox(height: 29.0),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            backgroundColor: Constants.background2,
            appBar: AppBar(
              title: const Text('Calendar'),
            ),
            body: SafeArea(
                child: Center(
                    child: Container(
                        margin: const EdgeInsets.all(20.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              // Content starts here
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
                                    if (snapshot.hasData) {
                                      List<dynamic> results =
                                          snapshot.data?.docs ?? [];

                                      // Produce list of date and times
                                      List<FlowData> flowData =
                                      produceListOfFlowData(results);

                                      Map<DateTime, List<String>> my_events = {};
                                      for (int i = 0; i < flowData.length; i++) {
                                        DateTime key = flowData[i].date_time;
                                        List<String> value = flowData[i].flowy;

                                        my_events[key] = value;
                                      }

                                      _events = my_events;

                                      return buildBody();
                                    }
                                    else{
                                      return const Center(
                                          child: SizedBox(
                                              width: 100,
                                              height: 100,
                                              child: CircularProgressIndicator(
                                                  strokeWidth: 12,
                                                  color: Constants.color2)));
                                    }
                                  })
                            ]))))));
  }
}
