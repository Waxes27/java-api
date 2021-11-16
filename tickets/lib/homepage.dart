import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tickets/pages/issues_page.dart';
import 'dart:convert';
import 'pages/floor.dart';
import 'pages/endpage.dart';

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
      appBar: AppBar(title: _bar()),
      body: _homePageBody(context),
    );
  }

  void _goToIssues() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return IssuesPage();
    }));
  }

  // void _goToThankYou() {
  //   Navigator.of(context)
  //       .push(MaterialPageRoute(builder: (BuildContext context) {
  //     return _thankYou(context);
  //   }));
  // }

  // void _goToFloor() {
  //   Navigator.of(context)
  //       .push(MaterialPageRoute(builder: (BuildContext context) {
  //     return _floor(context);
  //   }));
  // }

  // Future<http.Response> createIssue() async {
  //   String ip = "102.221.36.216";
  //   return await http.post(
  //     Uri.parse('http://$ip:4444/tickets'),
  //     body: jsonEncode(<String, String>{
  //       "author": usernameIn,
  //       "issue": issue,
  //       "campus": "JHB",
  //       "floor": floor,
  //     }),
  //   );
  // }

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

  Widget _bar() {
    return AppBar(
        title: const Center(
      child: Text("Welcome to the WeThinkCode_ Ticketing System"),
    ));
  }

  Widget _thankYou(BuildContext context) {
    return EndPage();
  }
  // return Scaffold(
  //   backgroundColor: Colors.blue,
  //   appBar: AppBar(title: _bar()),
  //   body: const Center(
  //     child: Text(
  //       "Your ticket has been lodged... Give it about 1 Hour to reach resolution",
  //       style: TextStyle(
  //         fontSize: 24,
  //         fontFamily: "aria",
  //       ),
  //     ),
  //   ),
  // );

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
                  String qwer = '[{"campus":"JHB"},{"campus":"CPT"}]';
                  print(json.decode(qwer)[0]);
                  usernameIn = text;
                  // Navigator.pop(context);
                  _goToIssues();
                },
                autofocus: true,
              ),
            )));
  }
}
