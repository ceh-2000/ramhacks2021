import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

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
      DateTime.utc(2021, 8, 25): ['Tampon', 'Tampon'],
      DateTime.utc(2021, 8, 26): ['Tampon', 'Tampon', 'Tampon', 'Tampon', 'Tampon'],
      DateTime.utc(2021, 8, 27): ['Tampon', 'Tampon', 'Tampon', 'Tampon'],
      DateTime.utc(2021, 8, 28): ['Tampon'],
      DateTime.utc(2021, 9, 22): ['Tampon', 'Tampon'],
      DateTime.utc(2021, 9, 23): ['Tampon', 'Tampon', 'Tampon', 'Tampon', 'Tampon'],
      DateTime.utc(2021, 9, 24): ['Tampon', 'Tampon', 'Tampon' ],
      DateTime.utc(2021, 9, 25): ['Tampon', 'Tampon'],
    };
  }

  List<dynamic> _getEventsForDay(day){
    return _events[day] ?? [];
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
                                  markerMargin: EdgeInsets.symmetric(horizontal: 5.0),
                                  markerDecoration: Icon(
                                    Icons.invert_colors,
                                    color: Colors.red,
                                    size: 15.0,
                                  ),
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
                                onDaySelected: (selectedDay, focusedDay) {
                                  if (!isSameDay(_selectedDay, selectedDay)) {
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
                                calendarBuilders: CalendarBuilders(
                                ),

                              ),
                              SizedBox(height: Constants.spacer),
                              _getEventsForDay(_selectedDay).length > 0 ? Text('Number of tampons: '+_getEventsForDay(_selectedDay).length.toString(), style: TextStyle(fontSize: Constants.mediumFont)) : const SizedBox(height: 29.0),
                            ]))))));
  }
}
