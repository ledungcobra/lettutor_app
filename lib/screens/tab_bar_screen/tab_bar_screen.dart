import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lettutor_app/screens/chat_screen/chat_screen.dart';
import 'package:lettutor_app/screens/courses/courses_screen.dart';
import 'package:lettutor_app/screens/home/home_screen.dart';
import 'package:lettutor_app/screens/settings/settings_screen.dart';
import 'package:lettutor_app/screens/tutors/tutors_screen.dart';
import 'package:lettutor_app/screens/upcoming/upcoming_screen.dart';
import 'package:lettutor_app/utils/mixing.dart';

import '../../services/chat_service.dart';
import '../../widgets/chat_floating_button.dart';

class TabBarScreen extends StatefulWidget with Dimension {
  const TabBarScreen({super.key});

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  int _selectedIndex = 0;
  final List<Widget> _widgets = [
    HomeScreen(),
    CoursesScreen(),
    TutorsScreen(),
    UpcomingScreen(),
    SettingsScreen(),
  ];

  ChatService get chatService => Get.find<ChatService>();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    Get.find<ChatService>().dispose();
    super.dispose();
  }

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
      floatingActionButton: ChatFloatingButton(
        background: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.blueGrey[200],
          ),
          width: 50,
          height: 50,
        ),
        onClick: () => Get.to(ChatScreen()),
        messageStyle: TextStyle(color: Colors.red),
      ),
    );
  }
}
