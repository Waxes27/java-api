import 'package:flutter/material.dart';
import 'package:tickets/pages/tickets/tickets.dart';
import './campus.dart';
import 'package:tickets/pages/homepage.dart';
import 'package:tickets/api/api.dart';
import 'floor.dart';
import 'issues.dart';

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
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            const Padding(padding: EdgeInsets.all(50)),
            FutureBuilder(
                future: createIssue(usernameIn, issue, campus, floor, category),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    return Center(
                        child: Flexible(
                            fit: FlexFit.loose,
                            child: Card(
                                shadowColor: Colors.blue,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: <Widget>[
                                      const Padding(
                                          padding: EdgeInsets.all(50)),
                                      ListTile(
                                        title: SingleChildScrollView(
                                            child: Column(
                                          children: <Widget>[
                                            const Center(
                                              child: Text(
                                                "Your ticket has been logged with these details.",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "aria",
                                                ),
                                              ),
                                            ),
                                            const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 30)),
                                            Text(
                                                "Reference ID: ${snapshot.data.toString()}"),
                                            const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 30)),
                                            Text(
                                                "You will recieve an email on $usernameIn@student.wethinkcode.co.za"),
                                            const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 30)),
                                            ElevatedButton.icon(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pushAndRemoveUntil(
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                    return const Tickets();
                                                  }), (route) => false);
                                                  // Navigator.of(context).popUntil((route) => route.isFirst);
                                                },
                                                icon: Icon(Icons.home),
                                                label: Text("Return Home"))
                                          ],
                                        )),
                                        leading: const Icon(
                                          Icons.perm_identity,
                                          color: Colors.green,
                                        ),
                                      ),
                                      // Text("Reference ID: ${snapshot.data.toString()}"),
                                      const Padding(
                                          padding: EdgeInsets.all(50)),
                                    ],
                                  ),
                                ))));
                  } else {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                }),

            // const Padding(padding: EdgeInsets.all(80)),

            // Text("Your your reference number is: ")
          ],
        )));
  }
}
