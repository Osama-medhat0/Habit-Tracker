import 'package:flutter/material.dart';
import 'package:habit_tracker/pages/dashboard_screen.dart';
import 'package:habit_tracker/pages/edit_habit_page.dart';
import 'package:habit_tracker/pages/login.dart';
import 'package:habit_tracker/pages/sign_up.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

void main() async {
  //firebase
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Firebase.initializeApp();
  //Hive init
  await Hive.initFlutter();

  //open box
  // await Hive.openBox("habit_Database");
  await Hive.openBox("userBox");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
    // return MaterialApp(debugShowCheckedModeBanner: false, home: Login());
    return MaterialApp(debugShowCheckedModeBanner: false, home: Register());
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   home: DashboardScreen(),
    // );
  }
}
