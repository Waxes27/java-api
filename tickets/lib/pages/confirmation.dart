import 'package:flutter/material.dart';
import 'package:tickets/pages/endpage.dart';
import 'campus.dart';
import 'floor.dart';
import 'category.dart';
import 'package:tickets/pages/homepage.dart';

var now = DateTime.now();
// String referenceId = "";

class ConfirmationPage extends StatefulWidget {
  @override
  ConfirmationPageState createState() => ConfirmationPageState();
}

class ConfirmationPageState extends State<ConfirmationPage> {
  final List<String> listOfData = [usernameIn, category, campus, floor, ""];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Here is your Ticket"),
        ),
        body: Center(
            child: ListView.builder(
                itemCount: listOfData.length,
                itemBuilder: (context, index) {
                  return _buildRow(context, index);
                })));
  }

  Widget _buildRow(BuildContext context, int index) {
    switch (index) {
      case 0:
        return ListTile(title: Text("Username: ${listOfData[index]}"));
      case 1:
        return ListTile(title: Text("Issue Category: ${listOfData[index]}"));
      case 2:
        return ListTile(title: Text("Campus: ${listOfData[index]}"));
      case 3:
        return ListTile(title: Text("Floor Number: ${listOfData[index]}"));

      default:
        return ListTile(
            title: ElevatedButton(
          child: const Text("Confirm"),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return EndPage();
            }));
          },
        ));
    }
  }
}
