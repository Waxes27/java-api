import 'package:flutter/material.dart';
import 'package:tickets/pages/campus.dart';
import 'package:tickets/pages/confirmation.dart';
import 'endpage.dart';

class FloorPage extends StatefulWidget {
  @override
  FloorPageState createState() => FloorPageState();
}

String default_floor() {
  switch (campus.toLowerCase()) {
    case "jhb":
      return "4th";
    case "cpt":
      return "1st";
    case "dbn":
      return "1st";
    default:
      return "1st";

  }
}

String floor = default_floor();

class FloorPageState extends State<FloorPage> {
  bool disabled = false;

  List<DropdownMenuItem<String>> floors() {
    switch (campus.toLowerCase()) {
      case "jhb":
        return <String>['4th', '5th', '6th']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList();

      case "cpt":
        return <String>['1st', '2nd']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList();

      default:
        return <String>['1st']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Center(
          child: Text("Whats's your floor number?"),
        )),
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
                items: floors(),
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
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext constext) {
                      return ConfirmationPage();
                    }));
                  },
                ),
              ),
              const Padding(padding: EdgeInsets.all(50)),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext constext) {
                      return ConfirmationPage();
                    }));
                  },
                  child: const Text("Continue"))
            ]));
  }
}
