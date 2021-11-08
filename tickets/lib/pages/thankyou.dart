import 'package:flutter/material.dart';

class EndPage extends StatefulWidget {
  @override
  EndPageState createState() => EndPageState();
}

class EndPageState extends State<EndPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blue,
      appBar: AppBar(title: _bar()),
      body: const Center(
        child: Text(
          "Your ticket has been lodged... Give it about 1 Hour to reach resolution",
          style: TextStyle(
            fontSize: 24,
            fontFamily: "aria",
          ),
        ),
      ),
    );
  }
}
