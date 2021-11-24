import 'package:flutter/material.dart';
import './campus.dart';
import 'package:tickets/homepage.dart';
import 'package:tickets/api/api.dart';
import 'floor.dart';
import 'category.dart';

class EndPage extends StatefulWidget {
  @override
  EndPageState createState() => EndPageState();
}

class EndPageState extends State<EndPage> {
  String id = "";
  String text = "Click here for ticket details";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.blueAccent,
        appBar: AppBar(
            title: const Center(
          child: Text("WeThinkCode_ Ticketing"),
        )),
        body: SingleChildScrollView( child:Column(
          children: <Widget>[
            

            const Padding(padding: EdgeInsets.all(50)),
            FutureBuilder(
                future: createIssue(usernameIn, category, campus, floor),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    
                    return Center(
                      child: Flexible(
                        fit: FlexFit.loose,
                        child: Card(
                        shadowColor: Colors.blue,
                        child: SingleChildScrollView( child:
                        Column(
                          children: <Widget>[
                          const Padding(padding: EdgeInsets.all(50)),
                          ListTile(
                            title: SingleChildScrollView( child:Column(children: <Widget>[
                              const Center(
                                child: Text(
                                  "Your ticket has been logged with these details.",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "aria",
                                  ),
                                ),
                              ),
                              const Padding(padding: EdgeInsets.symmetric(vertical: 30)),
                              Text("Reference ID: ${snapshot.data.toString()}"),
                              const Padding(padding: EdgeInsets.symmetric(vertical: 30)),
                              Text("You will recieve an email on $usernameIn@student.wethinkcode.co.za"),
                            ],)),
                            leading: const Icon(Icons.perm_identity),
                            ),
                          // Text("Reference ID: ${snapshot.data.toString()}"),
                          const Padding(padding: EdgeInsets.all(50)),

                        ],), 
                    ))));
                  } else {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );}
                }),

            // const Padding(padding: EdgeInsets.all(80)),

            // Text("Your your reference number is: ")
          ],
        )));
  }
}

