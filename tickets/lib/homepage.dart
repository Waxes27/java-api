import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


dynamic usernameIn;
dynamic issueIn;
dynamic campus;


class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  void _goToIssues() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return _issueHomePage(context);
    }));
  }

  void _goToThankYou(){
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
      return _thankYou(context);
    }));
  }

  void _goToFloor(){
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
    return _floor(context);
    }));
  }


  Future<http.Response> createIssue() async {
    return await http.post(Uri.parse('http://localhost:4444/tickets'),
      body: jsonEncode(<String, String>{
        "author" : usernameIn,
        "issue" : issueIn,
        "campus" : "JHB",
      }),
    );
  }


  Widget _floor(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: _bar(context),
      ),
      body: Container(
            padding: const EdgeInsets.all(50.0),
            child: Center(
              child: TextField(
                decoration: const InputDecoration(
                  hintText: "What is your floor number? (e.g. 4)",
                  contentPadding: EdgeInsets.all(24.0)),
                onSubmitted: (text) {
                  usernameIn = text;
                  _goToThankYou();
                  createIssue();
                },
              ),
            ))
    );
  }


  Widget _bar(BuildContext context) {
    return AppBar(
        title: const Center(
      child: Text("Welcome to the WeThinkCode_ Ticketing System"),
    ));
  }


  Widget _thankYou(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(title: _bar(context)),
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
                  _goToIssues();
                },
              ),
            )));
            
  }
  
  Widget _issueHomePage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: _bar(context),),
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
                  _goToFloor();
                },
              ),
            )));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: _bar(context)),
      body: _homePageBody(context),
      
    );
  }
}