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
      body: Center(
          child: Text(
        'Hello 123',
        style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.8,
            fontFamily: 'Lora',
            color: Colors.grey[600]),
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          // Respond to button press
        },
        child: Text('Click '),
      ),
    );
  }
}
