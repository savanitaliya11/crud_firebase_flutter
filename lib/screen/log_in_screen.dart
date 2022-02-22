// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class LogIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        margin: EdgeInsets.all(10),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(hintText: 'xyz@gmail.com'),
              ),
              TextField(
                decoration: InputDecoration(hintText: 'Enter your password'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () {}, child: Text('New User? Register')),
                  ElevatedButton(onPressed: () {}, child: Text('Log In')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
