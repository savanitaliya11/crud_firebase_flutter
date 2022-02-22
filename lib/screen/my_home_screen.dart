import 'package:crud_firebase_flutter/google/google_screen.dart';

import '../../email/log_in_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 30,
                child: GestureDetector(
                  child: Image.asset('images/email.png'),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LogIn(),
                      )),
                ),
              ),
              CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 30,
                child: GestureDetector(
                  child: Image.asset('images/google.png'),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GoogleScreen(),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
