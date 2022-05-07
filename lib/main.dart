// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int champId = 24;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          backgroundColor: Colors.grey[850],
          title: Center(child: Text("The Champ - ID Card ")),
          elevation: 0.0,
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                champId += 1;
              });
            },
            backgroundColor:Colors.grey[800],
            child: Icon(Icons.add)),
        body: Padding(
            padding: EdgeInsets.fromLTRB(30, 30, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                      backgroundImage: AssetImage("assets/avatar.webp"),
                      radius: 40.0),
                ),
                Divider(height: 60.0, color: Colors.grey[800]),
                Text('NAME',
                    style:
                        TextStyle(color: Colors.grey[400], letterSpacing: 2.0)),
                Text('John',
                    style: TextStyle(
                        // color: Colors.brown[300],
                        fontSize: 20.0,
                        letterSpacing: 2.0,
                        color: Colors.amberAccent[200])),
                SizedBox(height: 20.0),
                Text('ID',
                    style:
                        TextStyle(color: Colors.grey[400], letterSpacing: 2.0)),
                Text('$champId',
                    style: TextStyle(
                        // color: Colors.brown[300],
                        fontSize: 20.0,
                        letterSpacing: 2.0,
                        color: Colors.amberAccent[200])),
                SizedBox(height: 20.0),
                Row(
                  children: [
                    Icon(
                      Icons.email,
                      color: Colors.grey[400],
                    ),
                    SizedBox(width: 10.0),
                    Text('John@hotmail.com',
                        style: TextStyle(
                            color: Colors.amberAccent[200], fontSize: 20.0))
                  ],
                )
              ],
            )));
  }
}
