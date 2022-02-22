import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataScreen extends StatelessWidget {
  String? name;
  String? email;
  dynamic? imageUrl;
  DataScreen({this.email, this.imageUrl, this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text('${name}'),
            Text('${email}'),
            Image.network(imageUrl)
          ],
        ),
      ),
    );
  }
}
