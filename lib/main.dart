// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatelessWidget {
  // const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Hello 000 '),
          centerTitle: true,
          backgroundColor: Colors.lightGreen),
      body: Image.asset(
          "assets/beauty-1.jpg"),
    );
  }
}
