import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tickets/api/models/ticket.dart';
import 'package:tickets/pages/homepage.dart';
import 'package:tickets/api/api.dart';
import 'issues.dart';

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
      leading: const Icon(Icons.ac_unit, color: Colors.amber),
      title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TextButton(child: Text(json["referenceId"]), onPressed: () {}),
            Text(json["issue"]),
            Text(json["date"]),
          ]),
    );
  }

  List<DataRow> _buildRows(List listOfJson) {
    print('STUFF:    ${listOfJson.map((json) => DataRow(cells: [
              DataCell(Text(json["issue"]))
            ]))}');
    return listOfJson
        .map((json) => DataRow(cells: [
          DataCell(
            Icon(
              Icons.ac_unit,
              color: json["completed"]=="completed".toUpperCase()?Colors.green:
              json["completed"]=="pending".toUpperCase()?Colors.amber:
              Colors.red,
              )
            
            ),
          DataCell(TextButton(
            onPressed: (){},
            child: Text(json["referenceId"])
            )),
          DataCell(Text(json["issue"])),
          // DataCell(Text(json["completed"].toString().toLowerCase())),
          ]))
        .toList();
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
                return Flexible(
                        child: SingleChildScrollView(
                            child: Center(
                  child: DataTable(
                    showBottomBorder: true,
                    horizontalMargin: 20,
                    columnSpacing: 102,
                    // dataRowColor: ,
                    // dividerThickness: ,

                    columns: const [
                      DataColumn(label: Flexible(child: Text("Status"))),
                      DataColumn(
                          label: Flexible(child: Text("Reference Number"))),
                      DataColumn(label: Flexible(child: Text("Issue"))),
                      // DataColumn(label: Flexible(child: Text("Status"))),
                    ],
                    rows: _buildRows(stuff),
                  ),
                )));
                // return ListView.builder(
                //     itemCount: stuff.length,
                //     itemBuilder: (context, item) {
                //       return Flexible(child: buildRow(stuff[item]));
                //     });
              }
              return const CircularProgressIndicator.adaptive();
            },
          ),
        ));
  }
}
