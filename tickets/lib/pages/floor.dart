import 'package:flutter/material.dart';

class FloorPage extends StatefulWidget {
  @override
  FloorPageState createState() => FloorPageState();
}

class FloorPageState extends State<FloorPage> {
  String dropdownValue = 'n/a';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: _bar(),
        // ),
        body: Container(
      padding: const EdgeInsets.all(50.0),

      child: Center(
          child: DropdownButton<String>(
        value: dropdownValue,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String? newValue) {
          setState(() {
            print("$newValue $dropdownValue");
            dropdownValue = newValue!;
          });
        },
        items: <String>['4th', '5th', '6th', 'n/a']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      )),

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
    ));
  }
}
