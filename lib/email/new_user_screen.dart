// ignore_for_file: prefer_const_constructors



import 'log_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Card(
            margin: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextFormField(
                      validator: (v) {
                        v == null || v.isEmpty ? 'Required' : null;
                      },
                      controller: _emailController,
                      decoration: InputDecoration(hintText: 'xyz@gmail.com'),
                    ),
                    TextFormField(
                      validator: (v) {
                        v == null || v.isEmpty ? 'Required' : null;
                      },
                      controller: _passwordController,
                      decoration:
                          InputDecoration(hintText: 'Enter your password'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LogIn(),
                                  ));
                            },
                            child: Text('Existing User? Sign In')),
                        ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  _auth
                                      .createUserWithEmailAndPassword(
                                          email: _emailController.text,
                                          password: _passwordController.text)
                                      .then(
                                        (value) => ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                backgroundColor:
                                                    Colors.greenAccent,
                                                content: Text(
                                                    'Registration Successfully')))
                                            .closed
                                            .then((value) => LogIn()),
                                      );
                                } catch (e) {
                                  print(e);
                                }
                              }
                            },
                            child: Text('Register')),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
