import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lettutor_app/screens/courses/courses_screen.dart';
import 'package:lettutor_app/screens/home/home_screen.dart';
import 'package:lettutor_app/screens/settings/settings_screen.dart';
import 'package:lettutor_app/screens/tutors/tutors_screen.dart';
import 'package:lettutor_app/screens/upcoming/upcoming_screen.dart';
import 'package:lettutor_app/services/course_service.dart';
import 'package:lettutor_app/services/tutor_service.dart';
import 'package:lettutor_app/services/user_service.dart';
import 'package:lettutor_app/utils/mixing.dart';

void main() {
  setUpIOC();
  runApp(const MyApp());
}

void setUpIOC() {
  GetIt.I.registerSingleton<TutorService>(TutorService());
  GetIt.I.registerSingleton<UserService>(UserService());
  GetIt.I.registerSingleton<CourseService>(CourseService());
}

class MyApp extends StatefulWidget with Dimension {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static List<Widget> _widgets = <Widget>[
    HomeScreen(),
    CoursesScreen(),
    TutorsScreen(),
    UpcomingScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lettutor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        appBarTheme: AppBarTheme(
            backgroundColor: Colors.white, foregroundColor: Colors.black),
      ),
      home: Scaffold(
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
      ),
    );
  }
}
