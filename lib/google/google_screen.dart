// ignore_for_file: prefer_const_constructors

import 'package:crud_firebase_flutter/google/google_sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'data_screen.dart';

class GoogleScreen extends StatelessWidget {
  const GoogleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      SignIn signin = SignIn();
                      signin.signInWithGoogle().then((value) async {
                        if (value != null) {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DataScreen(
                                  name: signin.name,
                                  email: signin.email,
                                  imageUrl: signin.imageUrl,
                                ),
                              ));
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      });
                    },
                    child: Text('Google')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
