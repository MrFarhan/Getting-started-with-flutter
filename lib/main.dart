// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import "quote.dart";

void main() => runApp(MaterialApp(home: Quotes()));

class Quotes extends StatefulWidget {
  const Quotes({Key? key}) : super(key: key);

  @override
  State<Quotes> createState() => _QuotesState();
}

class _QuotesState extends State<Quotes> {
  Widget quoteTemplate(quote) {
    return QuoteCard(quote);
  }

  List<Quote> quotes = [
    Quote(
        author: "unknown",
        text: "Any fool can write code that a computer can understand."),
    Quote(author: "unknown", text: "First, solve the problem."),
    Quote(
        author: "unknown",
        text: "Experience is the name everyone gives to their mistakes. "),
    Quote(
        author: "Coco Chanel",
        text: "In order to be irreplaceable, one must always be different"),
    Quote(
        author: "unknown",
        text: "Java is to JavaScript what car is to Carpet."),
    Quote(author: "unknown", text: "Knowledge is power."),
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
            children: quotes.map((quote) => quoteTemplate(quote)).toList(),
          ),
        ));
  }
}

class QuoteCard extends StatelessWidget {
  final Quote quote;
  QuoteCard(this.quote);

  // const QuoteCard({
  //   Key? key,
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("quote.text"),
            SizedBox(height: 10.0),
            Text(
              "quote.author",
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
