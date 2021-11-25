import 'package:app_tut/ticketModel.dart';
import 'package:app_tut/pages/ticket_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'pages/details_page.dart';

final ip = "102.221.36.216";
final uri = "http://$ip:4444";
void main() => runApp(ConsoleApp());

class ConsoleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ticket Console",
      home: _HomePage(),
    );
  }
}

class _HomePage extends StatefulWidget {
  createState() => _HomePageState();
}
/*
POST {ip}/ticket/update/{id}
*/


class _HomePageState extends State<_HomePage> {
  // final GlobalKey<TicketPageState> _key = GlobalKey();
  late Future<List<ticketModel>> data;

  Color? _color(ticket) {
    if (ticket.isCompleted() == Status.INCOMPLETED) {
      return Colors.red;
    } else if (ticket.isCompleted() == Status.PENDING) {
      return Colors.amber[600];
    }
    return Colors.lightGreenAccent[400];
  }

  IconData _iconData(ticket) {
    if (ticket.getCategory() == "HARDWARE") {
      return Icons.mouse;
    } else if (ticket.getCategory() == "SOFTWARE") {
      return Icons.adb_sharp;
    } else if (ticket.getCategory() == "LMS") {
      // return Icons.cable_rounded;
      return Icons.code;
    } else if (ticket.getCategory() == "MAINTENENCE") {
      return Icons.build_rounded;
    }
    return Icons.not_listed_location_rounded;
  }

  Icon _dynamicIcon(ticket) {
    return Icon(_iconData(ticket), color: _color(ticket));
  }

    SingleChildScrollView _dataTable(tickets) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          sortColumnIndex: 0,
          sortAscending: true,
          columns: [
             DataColumn(
                label: Container(child: 
                        Flexible(fit: FlexFit.tight, 
                        child: Text('',
                                style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))),
                onSort: (i, b) {}),
             DataColumn(
                label: Container(child: Flexible(fit: FlexFit.tight, child: Text('Reference',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))),
                onSort: (i, b) {}),
             DataColumn(
                label: Container(child: Flexible(fit: FlexFit.tight, child: Text('Username',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))),
                onSort: (i, b) {}),
             DataColumn(
                label: Container(child: Flexible(fit: FlexFit.tight, child: Text('Date',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))),
                onSort: (i, b) {}),
             DataColumn(
                label: Container(child: Flexible(fit: FlexFit.tight, child: Text('Campus',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))),
                onSort: (i, b) {}),
             DataColumn(
                label: Container(child: Flexible(fit: FlexFit.tight, child: Text('Floor',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))),
                onSort: (i, b) {}),
             DataColumn(
                label: Container(child: Flexible(fit: FlexFit.tight, child: Text('Issue',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))),
                onSort: (i, b) {}),
             DataColumn(
                label: Container(child: Flexible(fit: FlexFit.tight, child: Text('Status',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))),
                onSort: (i, b) {}),
          ],
          rows: _buildrows(tickets),
        ));
  }

  List<DataRow> _buildrows(List tickets) {
    // tickets = data.getTickets();
    print("THESE ARE THE TICKETS: $tickets");
    // final ticketHandler handler = ticketHandler();
    return tickets
        .map((ticket) => DataRow(cells: [
              DataCell(_dynamicIcon(ticket)),
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
                  _goToTicketsDetails(ticket)
                  ////////////////////
                },
                child: Text(ticket.getRefID().toString()),
              )),
              DataCell(Text(ticket.getUsername())),
              DataCell(Text(ticket.getCreationDate())),
              DataCell(Text(ticket.getCampus())),
              DataCell(Text("${ticket.getFloor()}")),
              DataCell(Text(ticket.getProblem())),
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
                  if (ticket.isCompleted() == Status.INCOMPLETED)
                    {
                      setState(() {
                        ticket.pending();
                        editTicket(
                            ticket.getID(),
                            ticket
                                .isCompleted()
                                .toString()
                                .replaceAll("Status.", ''));
                      })
                    }
                  else if (ticket.isCompleted() == Status.PENDING)
                    {
                      setState(() {
                        ticket.complete();
                        editTicket(
                            ticket.getID(),
                            ticket
                                .isCompleted()
                                .toString()
                                .replaceAll("Status.", ''));
                      })
                    }
                },
                child: Text(
                    ticket.isCompleted().toString().replaceAll("Status.", "")),
              )),
            ]))
        .toList();
  }
  Future<List<ticketModel>> fetchTickets() async {
    final response = await http.get(Uri.parse("$uri/tickets"));
    List<ticketModel> _data = [];
    // return response.body;
    List jsonOb = await json.decode(response.body);
    for (var item in jsonOb) {
      print(item);
      _data.add(ticketModel.fromJson(item));
    }
    return _data;
  }

  void editTicket(id, status) async {
    final response =
        await http.post(Uri.parse("$uri/ticket/update/$id/$status"));
  }

  @override
  void initState() {
    super.initState();
    data = fetchTickets();
  }

  void _goToTicketsDetails(ticketModel ticket) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return DeatailsPage(
        ticket: ticket, 
        dynamicIcon: _dynamicIcon,
        dynamicColor: _color,);
    }));
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("C O N S O L E")),
        ),
        body: FutureBuilder(
          future: data,
          initialData: [],
          builder: (context, snapshot){
          if (snapshot.hasError) {
          return const Center(child: Text('An Error Occurred'));
          }
          else if (snapshot.hasData) {
         
          return _dataTable(snapshot.data);
          }
          else {
	
        return Text('State: ${snapshot.connectionState}');
	
      }
          }
    ));
}
    }
        
        // Center(
        //   child: ElevatedButton(
        //     child: Text("Go to tickets page."),
        //     onPressed: () {
        //       _goToTickets();
        //     },
        //   ),
        // ));
