import 'package:flutter/material.dart';
import 'package:tickets/pages/homepage.dart';
import 'package:tickets/api/api.dart';
import 'category.dart';

class Tickets extends StatefulWidget {
  const Tickets({Key? key}) : super(key: key);

  @override
  _TicketsState createState() => _TicketsState();
}

class _TicketsState extends State<Tickets> {
  Widget _bar() {
    return AppBar(
        title: const Center(
      child: Text("WeThinkCode_ Ticketing"),
    ));
  }

  void _goToIssues() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return IssuesPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: _bar()),
      body: FutureBuilder(
        future: getUserTickets(usernameIn),
        builder: (BuildContext context, snapshot) {
          _goToIssues();
          return Container();
        },
      ),
    );
  }
}
