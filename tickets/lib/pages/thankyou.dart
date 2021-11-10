import 'package:flutter/material.dart';

class EndPage extends StatefulWidget {
  @override
  EndPageState createState() => EndPageState();
}

class EndPageState extends State<EndPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: const Center(
      child: Text("Welcome to the WeThinkCode_ Ticketing System"),
    )),
      body: Column(
        children: const <Widget>[ Center(
        child: Text(
          "Your ticket has been lodged...",
          style: TextStyle(
            fontSize: 24,
            fontFamily: "aria",
          ),
        ),
      ),


      
      ],
    )
    );
  }
}
