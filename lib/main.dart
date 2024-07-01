import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do/pages/home_page.dart';

void main() async {
  // Init Hive
  await Hive.initFlutter();

  // Open a box
  await Hive.openBox('mybox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ThemeData(primaryColor: const Color.fromARGB(255, 70, 136, 235)),
    );
  }
}
