import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tickets/api/models/ticket.dart';
import 'package:tickets/pages/homepage.dart';
import 'package:tickets/api/api.dart';
import 'category.dart';

class Tickets extends StatefulWidget {
  const Tickets({Key? key}) : super(key: key);

  @override
  _TicketsState createState() => _TicketsState();
}

class _TicketsState extends State<Tickets> {
  late Future stuff;
  AppBar _bar() {
    return AppBar(
        title: const Center(
      child: Text("Here are your Tickets"),
    ));
  }

  void _goToIssues() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return IssuesPage();
    }));
  }

  Widget buildRow(Map json) {
    print(json);
    return ListTile(
      leading: const Icon(
        Icons.ac_unit,
        color: Colors.amber
        ),
      title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TextButton(
              child: Text(json["referenceId"]),
              onPressed: (){}),
            Text(json["issue"]),
            Text(json["date"]),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
      child: Text("Here are your Tickets"),
    )),
      bottomNavigationBar: BottomAppBar(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                    return HomePage();
                }));
              },
              icon: const Icon(Icons.add_comment),
              label: const Text("Add new ticket"))
        ],
      )),
      body: Card(
        child: FutureBuilder(
        future: getUserTickets("sibonelo"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List stuff = jsonDecode(snapshot.data.toString());
            return ListView.builder(
                itemCount: stuff.length,
                itemBuilder: (context, item) {
                  return Flexible(child: buildRow(stuff[item]));
                });
          }
          return const CircularProgressIndicator.adaptive();
        },
      ),
    ));
  }
}
