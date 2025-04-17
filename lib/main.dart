import 'package:flutter/material.dart';
import 'package:habit_tracker/pages/dashboard_screen.dart';
import 'package:habit_tracker/pages/home_page.dart';
import 'package:habit_tracker/pages/login.dart';
import 'package:habit_tracker/pages/register.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  //Hive init
  await Hive.initFlutter();

  //open box
  await Hive.openBox("habit_Database");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
    return MaterialApp(debugShowCheckedModeBanner: false, home: Login());
    // return MaterialApp(debugShowCheckedModeBanner: false, home: Register());
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   home: DashboardScreen(),
    // );
  }
}
