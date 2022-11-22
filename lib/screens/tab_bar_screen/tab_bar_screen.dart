import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/screens/courses/courses_screen.dart';
import 'package:lettutor_app/screens/home/home_screen.dart';
import 'package:lettutor_app/screens/settings/settings_screen.dart';
import 'package:lettutor_app/screens/tutors/tutors_screen.dart';
import 'package:lettutor_app/screens/upcoming/upcoming_screen.dart';
import 'package:lettutor_app/utils/mixing.dart';


class TabBarScreen extends StatefulWidget with Dimension {
  const TabBarScreen({super.key});

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  // This widget is the root of your application.
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _widgets = <Widget>[
    HomeScreen(),
    CoursesScreen(),
    TutorsScreen(),
    UpcomingScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: 'Courses',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Tutors',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.schedule),
              label: 'Upcoming',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
        ),
        body: _widgets[_selectedIndex],
    );
  }
}
