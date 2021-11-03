import 'package:app_tut/ticketModel.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// L mockData = ticketModel();
var mockData = ticketModel();
final uri = "http://localhost:4444/tickets";

void main(List<String> args) => runApp(ConsoleApp());
class ConsoleApp extends StatefulWidget {
  @override
  ConsoleAppState createState() {
    return ConsoleAppState();
  }
}

class ConsoleAppState extends State<ConsoleApp> {
  late Future<ticketModel> futureTickets;

  @override
  void initState() {
    super.initState();
    futureTickets = fetchTickets();
  }

  SingleChildScrollView dataTable(tickets) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
            sortColumnIndex: 1,
            sortAscending: true,
            columns: [
              DataColumn(
                  label: Text('ID',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  numeric: true,
                  onSort: (i, b) {}),
              DataColumn(
                  label: Text('Username',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  numeric: true,
                  onSort: (i, b) {}),
              DataColumn(
                  label: Text('Campus',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  numeric: true,
                  onSort: (i, b) {}),
              DataColumn(
                  label: Text('Issue',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  numeric: true,
                  onSort: (i, b) {}),
              DataColumn(
                  label: Text('Status',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  numeric: true,
                  onSort: (i, b) {}),
              DataColumn(
                  label: Text('',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  numeric: true,
                  onSort: (i, b) {}),
            ],
            rows: _buildrows(tickets)));
  }

  List<DataRow> _buildrows(tickets) {
    // print(tickets.getID());

    return tickets
        .map((ticket) => DataRow(cells: [
              DataCell(Text(ticket.getID.toString())),
              DataCell(Text(ticket.getUsername())),
              DataCell(Text(ticket.getCampus())),
              DataCell(Text(ticket.getProblem())),
              DataCell(
                Text(ticket.isCompleted().toString().replaceAll("Status.", "")),
              ),
              DataCell(TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                    overlayColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.hovered))
                          return Colors.blue.withOpacity(0.04);
                        if (states.contains(MaterialState.focused) ||
                            states.contains(MaterialState.pressed))
                          return Colors.blue.withOpacity(0.12);
                        return null; // Defer to the widget's default.
                      },
                    ),
                  ),
                  onPressed: () => {
                        if (ticket.isCompleted() == Status.Incomplete)
                          {
                            //////
                          }
                        else if (ticket.isCompleted() == Status.Pending)
                          {
                            //////
                          }
                      },
                  child: Text('Change State')))
              // DataCell(
              //   FloatingActionButton(
              // onPressed: () => {
              //   if (ticket.isCompleted() == Status.Incomplete)
              //     {ticket.PENDING()}
              //   else if (ticket.isCompleted() == Status.Pending)
              //     {ticket.COMPLETE()}
              // },
              //   ),
              // ),
            ]))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    // mockData.add(ticketModel(
    //   id: 1,
    //   userName: "kmthunzi",
    //   campus: "JHB",
    //   problem: "screen",
    //   date: DateTime.now().toString(),
    //   status: Status.Incomplete
    //   ));
    // mockData.add(ticketModel(
    //   id: 2,
    //   userName: "kingV",
    //   campus: "JHB",
    //   problem: "keybord",
    //   date: DateTime.now().toString(),
    //   status: Status.Incomplete
    //   ));
    // mockData.add(ticketModel(
    //   id: 3,
    //   userName: "KAtlego",
    //   campus: "JHB",
    //   problem: "Wifi drivers",
    //   date: DateTime.now().toString(),
    //   status: Status.Incomplete
    //   ));
    // mockData.add(ticketModel(
    //   id: 4,
    //   userName: "kmthunzi",
    //   campus: "JHB",
    //   problem: "deleted python",
    //   date: DateTime.now().toString(),
    //   status: Status.Incomplete
    //   ));

    return MaterialApp(
        title: "Console App",
        home: Scaffold(
            appBar: AppBar(
              title: Text("Console App"),
            ),
            body: Center(
                child: FutureBuilder(
                    future: futureTickets,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasData) {
                        
                        return Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            verticalDirection: VerticalDirection.down,
                            children: <Widget>[
                              Expanded(
                                  child: Container(
                                      padding: EdgeInsets.all(5),
                                      child: dataTable(snapshot.data)))
                            ]);
                      }
                      {
                        return Center();
                      }
                    }))));
  }

  Future<ticketModel> fetchTickets() async {
    final response = await http.get(Uri.parse(uri));
    
    List jsonOb = json.decode(response.body);
    // print("hello");

    if (response.statusCode == 200) {
      print("NEW JSON OBJECT: ${jsonOb[0]}");
      
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return ticketModel.fromJson(jsonOb[0]);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
