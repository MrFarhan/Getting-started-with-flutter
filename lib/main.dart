// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Quotes()));

class Quotes extends StatefulWidget {
  const Quotes({Key? key}) : super(key: key);

  @override
  State<Quotes> createState() => _QuotesState();
}

class _QuotesState extends State<Quotes> {
  List<String> quotes = [
    'Any fool can write code that a computer can understand. ...',
    'First, solve the problem. ...',
    'Experience is the name everyone gives to their mistakes. ',
    ' In order to be irreplaceable, one must always be different” - Coco Chanel ',
    'Java is to JavaScript what car is to Carpet.” ',
    'Knowledge is power.'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
            title: Text("Awesome Quotes"),
            centerTitle: true,
            backgroundColor: Colors.pink[300]),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: quotes.map((item) => Text(item)).toList(),
          ),
        ));
  }
}
