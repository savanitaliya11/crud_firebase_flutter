// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:crud_firebase_flutter/screen/log_in_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Firebase')),
      body: SafeArea(
        child: LogIn(),
      ),
    );
  }
}
