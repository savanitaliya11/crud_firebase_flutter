import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FaceBook extends StatefulWidget {
  const FaceBook({Key? key}) : super(key: key);

  @override
  State<FaceBook> createState() => _FaceBookState();
}

class _FaceBookState extends State<FaceBook> {
  bool loading = false;

  Future<void> loginFaceBook() async {
    setState(() {
      loading = true;
    });

    try {
      final facebookLoginResult =
          await FacebookAuth.instance.login(permissions: ['email']);
      final userData = await FacebookAuth.instance.getUserData();

      final facebookCredential = await FacebookAuthProvider.credential(
          facebookLoginResult.accessToken!.token);
      await FirebaseAuth.instance.signInWithCredential(facebookCredential);

      await FirebaseFirestore.instance.collection('facebookUser').add({
        'name': userData['name'],
        'email': userData['email'],
        'imageUrl': userData['picture']['data']['url'],
      });
    } on FirebaseAuthException catch (e) {
      log('EXCEPTION==>>> ${e}');
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FaceBook'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              TextButton(
                onPressed: () {
                  loginFaceBook();
                },
                child: Text('FaceBook'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
