import 'package:app_tut/ticketModel.dart';
import 'package:flutter/material.dart';

class TicketPage extends StatefulWidget {
  final List<ticketModel> tickets;

  TicketPage({Key? key, required this.tickets}) : super(key: key);

  @override
  TicketPageState createState() => TicketPageState();
}

class TicketPageState extends State<TicketPage> {
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
                label: Text('ID',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                onSort: (i, b) {}),
            DataColumn(
                label: Text('Username',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                onSort: (i, b) {}),
            DataColumn(
                label: Text('Campus',
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
              DataCell(Text(ticket.getID().toString())),
              DataCell(Text(ticket.getUsername())),
              DataCell(Text(ticket.getCampus())),
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
                      })
                    }
                  else if (ticket.isCompleted() == Status.Pending)
                    {
                      setState(() {
                        ticket.complete();
                      })
                    }
                },
                child: Text(
                    ticket.isCompleted().toString().replaceAll("Status.", "")),
              ))
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
}
