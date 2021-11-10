import 'package:flutter/material.dart';
import 'package:tickets/pages/floor.dart';
import 'thankyou.dart';

class CampusPage extends StatefulWidget {
  @override
  CampusPageState createState() => CampusPageState();
}

var otherIssue = "";
String campus = 'n/a';

class CampusPageState extends State<CampusPage> {
  bool disabled = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Center(
              child: Text("Where is your campus based?"),
            ) 
            ),
        body: Column(
            // padding: const EdgeInsets.all(50.0),

            children: <Widget>[
          const Padding(padding: EdgeInsets.all(50)),
          Center(
              child: DropdownButton<String>(
            value: campus,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? newValue) {
              setState(() {                
                print("$newValue $campus");
                campus = newValue!;
                // if (dropdownValue.toLowerCase() == "other") {
                //   setState(() {
                //     disabled = true;
                //   });
                // }
              });
            },

            items: <String>['JHB', 'CPT', 'DBN', 'n/a']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            
          )),


          // Visibility(
          //   visible: disabled,
          //   child: TextField(
          //     decoration: InputDecoration(
          //       contentPadding: const EdgeInsets.symmetric(horizontal: 50),
          //       hintText: "Please describe your issue. ",
          //       enabled: disabled,
          //     ),
          //     onSubmitted: (text) {
          //       otherIssue = text;
          //       Navigator.of(context)
          //           .push(MaterialPageRoute(builder: (BuildContext constext) {
          //         return FloorPage();
          //       }));
          //     },
          //   ),
          // ),

          const Padding(padding: EdgeInsets.all(50)),

          ElevatedButton(onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext constext) {
                  return FloorPage();
                }));
              }, child: const Text("Continue"))
        ]
            ));
  }
}
