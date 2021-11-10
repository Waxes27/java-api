import 'package:app_tut/ticketModel.dart';
import 'package:flutter/material.dart';

class TicketPage extends StatefulWidget {
  final List<ticketModel> tickets;
  final editTicket;

  TicketPage({Key? key, required this.tickets, required this.editTicket})
      : super(key: key);

  @override
  TicketPageState createState() => TicketPageState();
}

class TicketPageState extends State<TicketPage> {
  Color? _color(ticket) {
    if (ticket.isCompleted() == Status.Incomplete) {
      return Colors.red;
    } else if (ticket.isCompleted() == Status.Pending) {
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
      return Icons.cable_rounded;
    } else if (ticket.getCategory() == "MAINTENENCE") {
      return Icons.build_rounded;
    }
    return Icons.not_listed_location_rounded;
  }

  Icon _dynamicIcon(ticket) {
    return Icon(_iconData(ticket), color: _color(ticket));
  }

  //do_disturb_on_sharp
  //check_circle

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blue,
      appBar: AppBar(title: Text("Ticket Console")),
      body: SingleChildScrollView(child: dataTable(widget.tickets)),
    );
  }

  SingleChildScrollView dataTable(tickets) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          sortColumnIndex: 0,
          sortAscending: true,
          columns: [
            DataColumn(
                label: Text('',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                onSort: (i, b) {}),
            DataColumn(
                label: Text('Reference',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                onSort: (i, b) {}),
            DataColumn(
                label: Text('Username',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                onSort: (i, b) {}),
            DataColumn(
                label: Text('Date Issued',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                onSort: (i, b) {}),
            DataColumn(
                label: Text('Campus',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                onSort: (i, b) {}),
            DataColumn(
                label: Text('Floor',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                onSort: (i, b) {}),
            DataColumn(
                label: Text('Issue',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                onSort: (i, b) {}),
            DataColumn(
                label: Text('Status',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                onSort: (i, b) {}),
          ],
          rows: _buildrows(tickets),
        ));
  }

  List<DataRow> _buildrows(List<ticketModel> tickets) {
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
                  ////////////////////
                },
                child: Text(ticket.getRefID().toString()),
              )),
              DataCell(Text(ticket.getUsername())),
              DataCell(Text(ticket.getCreationDate())),
              DataCell(Text(ticket.getCampus())),
              DataCell(Text(ticket.getFloor().toString())),
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
                  if (ticket.isCompleted() == Status.Incomplete)
                    {
                      setState(() {
                        ticket.pending();
                        widget.editTicket(
                            ticket.getID(),
                            ticket
                                .isCompleted()
                                .toString()
                                .replaceAll("Status.", ''));
                      })
                    }
                  else if (ticket.isCompleted() == Status.Pending)
                    {
                      setState(() {
                        ticket.complete();
                        widget.editTicket(
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
}
