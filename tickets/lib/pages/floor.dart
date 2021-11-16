import 'package:flutter/material.dart';
import 'package:tickets/pages/confirmation.dart';
import 'endpage.dart';

class FloorPage extends StatefulWidget {
  @override
  FloorPageState createState() => FloorPageState();
}


String floor = '4th';

class FloorPageState extends State<FloorPage> {
  bool disabled = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Center(
              child: Text("Please enter your floor number?"),
            ) 
            ),
        body: Column(
            // padding: const EdgeInsets.all(50.0),

            children: <Widget>[
          const Padding(padding: EdgeInsets.all(50)),
          Center(
              child: DropdownButton<String>(
            value: floor,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? newValue) {
              setState(() {                
                print("$newValue $floor");
                floor = newValue!;
                if (floor.toLowerCase() == "other") {
                  setState(() {
                    disabled = true;
                  });
                }
              });
            },

            items: <String>['4th', '5th', '6th']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )),


          Visibility(
            visible: disabled,
            child: TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 50),
                hintText: "Please describe your issue. ",
                enabled: disabled,
              ),
              onSubmitted: (text) {
                floor = text;
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext constext) {
                  return ConfirmationPage();
                }));
              },
            ),
          ),
          const Padding(padding: EdgeInsets.all(50)),
          ElevatedButton(onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext constext) {
                  return ConfirmationPage();
                }));
              }, child: const Text("Continue"))
        ]

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
