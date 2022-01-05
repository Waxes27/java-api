import 'package:flutter/material.dart';
import 'pages/homepage.dart';
import 'pages/tickets/tickets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      title: "WTC Ticketing",
      home: Tickets(),
    );
  }
}
