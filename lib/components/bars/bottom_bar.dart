import 'package:flutter/material.dart';
import 'package:pinmarker/helpers/variables/global.dart';
import 'package:pinmarker/helpers/variables/style.dart';
import 'package:pinmarker/pages/dashboard/index.dart';
import 'package:pinmarker/pages/list/index.dart';
import 'package:pinmarker/pages/maps/index.dart';
import 'package:pinmarker/pages/trackvisit/index.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({key}) : super(key: key);

  @override
  BottomBarState createState() => BottomBarState();
}

class BottomBarState extends State<BottomBar> {
  final List<Widget> _widgetOptions = const <Widget>[
    DashboardPage(),
    MapsPage(),
    ListPage(),
    TrackVisit(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _widgetOptions.elementAt(selectedIndex),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(roundedLG),
            topLeft: Radius.circular(roundedLG),
          ),
          child: BottomNavigationBar(
            currentIndex: selectedIndex,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.map_sharp),
                label: 'Maps',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.location_on_sharp),
                label: 'Global List',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.gps_fixed),
                label: 'Track & Visit',
              ),
            ],
            backgroundColor: Colors.black,
            // unselectedLabelStyle: GoogleFonts.poppins(),
            // selectedLabelStyle: GoogleFonts.poppins(fontSize: 14),
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black,

            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
        ));
  }
}
