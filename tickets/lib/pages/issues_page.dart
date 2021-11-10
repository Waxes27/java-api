import 'package:flutter/material.dart';
import 'package:tickets/homepage.dart';
import 'package:tickets/pages/campus.dart';
import 'floor.dart';

  String issue = 'Other';
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

  // void _goToFloor() {
  //   Navigator.of(context)
  //       .push(MaterialPageRoute(builder: (BuildContext context) {
  //     return _floor(context);
  //   }));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Center(
              child: Text("What is the issue today?"),
            ) 
            ),
        body: Center(
          child: Column(
            // padding: const EdgeInsets.all(50.0),

            children: <Widget>[
              const Padding(padding: EdgeInsets.all(50)),
              Center(
                child: DropdownButton<String>(
                  value: issue,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      print("$newValue $issue");
                      issue = newValue!;
                      // if (issue.toLowerCase()=="other"){
                      //   setState(() {
                      //     disabled = true;

                      //   });
                      // }
                    });
                  },
                  items: <String>[
                    'Hardware',
                    'Software',
                    'LMS',
                    'Maintenance',
                    'Other'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),

              const Padding(padding: EdgeInsets.all(50)),
          
              ElevatedButton(onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext constext) {
                  return CampusPage();
                }));
              },
              child: const Text("Continue")),

            ])));
  }
}
