import 'package:flutter/material.dart';

class EndPage extends StatefulWidget {
  @override
  EndPageState createState() => EndPageState();
}

class EndPageState extends State<EndPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // backgroundColor: Colors.blueAccent,
      // appBar: AppBar(title: _bar()),
      body: Center(
        child: Text(
          "Your ticket has been lodged...",
          style: TextStyle(
            fontSize: 24,
            fontFamily: "aria",
          ),
        ),
      ),
    );
  }
}
