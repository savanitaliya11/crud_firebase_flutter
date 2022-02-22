import 'package:crud_firebase_flutter/screen/my_home_screen.dart';
import 'new_user_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogIn extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log In Screen'),
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
                                    builder: (context) => Register(),
                                  ));
                            },
                            child: Text('New User? Register')),
                        ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  auth
                                      .signInWithEmailAndPassword(
                                          email: _emailController.text,
                                          password: _passwordController.text)
                                      .then((value) => ScaffoldMessenger.of(
                                              context)
                                          .showSnackBar(SnackBar(
                                              content:
                                                  Text('LogIn Successfully')))
                                          .closed)
                                      .then((value) => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MyHome(),
                                          )));
                                } catch (e) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                        content: Text('${e}'),
                                        backgroundColor: Colors.red,
                                      ))
                                      .closed;
                                }
                              } else {
                                return null;
                              }
                            },
                            child: Text('Log In')),
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
