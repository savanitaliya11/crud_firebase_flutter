// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:crud_firebase_flutter/screen/my_home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: SafeArea(
        child: MyHome(),
      ),
    ));
  }
}
