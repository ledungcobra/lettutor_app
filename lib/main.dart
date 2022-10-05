import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lettutor_app/screens/tutors/tutor_screen.dart';
import 'package:lettutor_app/services/tutor_service.dart';
import 'package:lettutor_app/utils/mixing.dart';

void main() {
  setUpIOC();
  runApp(const MyApp());
}

void setUpIOC() {
  GetIt.I.registerSingleton<TutorService>(TutorService());
}

class MyApp extends StatelessWidget with Dimension {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lettutor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TutorsPage(),
    );
  }
}
