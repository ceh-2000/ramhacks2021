import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'constants.dart';
import 'report.dart';
import 'calendar.dart';
import 'data_vis.dart';
import 'mission.dart';

Future<void> main() async {
  // Checks to make sure everything is initialized
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Healthy Women',
      theme: ThemeData(
        primarySwatch: Constants.kToDark,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // List of pages we could show
  final List<Widget> _widgetOptions = <Widget>[
    Report(),
    Calendar(),
    DataVis(),
    Mission()
  ];


  // Index of which view to show from list of widget options
  int _selectedIndex = 0;

  late PageController _pageController; // = PageController();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      // Animated transition from one screen to the next
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.easeOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
          child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _selectedIndex = index);
              },
              children: _widgetOptions)),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Constants.color1Light,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outlined),
            label: 'Report',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_sharp),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Data',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_align_center),
            label: 'Mission',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Constants.color2Dark,
        unselectedItemColor: Constants.color1Dark,
        onTap: _onItemTapped,
      ),
    );
  }
}