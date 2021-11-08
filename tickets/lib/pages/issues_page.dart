import 'package:flutter/material.dart';
import 'package:tickets/homepage.dart';
import 'floor.dart';

class IssuesPage extends StatefulWidget {
  @override
  IssuesPageState createState() => IssuesPageState();
}

class IssuesPageState extends State<IssuesPage> {
  Widget _floor(BuildContext context) {
    return FloorPage();

    // child: TextField(
    //   decoration: const InputDecoration(
    //     hintText: "What is your floor number? (e.g. 4)",
    //     contentPadding: EdgeInsets.all(24.0)),
    //   onSubmitted: (text) {
    //     floor = text;
    //     _goToThankYou();
    //     createIssue();
    //   },
    // ),
    // ));
  }

  void _goToFloor() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return _floor(context);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: _bar(),
        ),
        body: Container(
            padding: const EdgeInsets.all(50.0),
            child: Center(
              child: TextField(
                decoration: const InputDecoration(
                    hintText: "What is the issue today?",
                    contentPadding: EdgeInsets.all(24.0)),
                onSubmitted: (text) {
                  issueIn = text;
                  // createIssue();
                  // _goToThankYou();
                  // Navigator.pop(context);
                  _goToFloor();
                },
                autofocus: true,
              ),
            )));
  }
}
