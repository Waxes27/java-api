import 'package:flutter/material.dart';
import 'package:tickets/pages/category.dart';
import 'package:tickets/pages/tickets.dart';
import 'floor.dart';
import 'endpage.dart';

dynamic usernameIn;
// dynamic issueIn;
// dynamic campus;
// dynamic floor;

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _bar(),
      body: _homePageBody(context),
    );
  }
  void _goToTickets(){
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return Tickets();
    }));
  }
  void _goToIssues() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return IssuesPage();
    }));
  }

  Widget _floor(BuildContext context) {
    return FloorPage();
  }

  AppBar _bar() {
    return AppBar(
        title: const Center(
      child: Text("WeThinkCode_ Ticketing"),
    ));
  }

  Widget _thankYou(BuildContext context) {
    return EndPage();
  }

  Widget _homePageBody(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.all(50.0),
            child: Center(
              child: TextField(
                decoration: const InputDecoration(
                    hintText: "Enter Username",
                    contentPadding: EdgeInsets.all(24.0)),
                onSubmitted: (text) {
                  usernameIn = text;
                  _goToIssues();
                },
                autofocus: true,
              ),
            )));
  }
}
