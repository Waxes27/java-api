import 'package:app_tut/ticketModel.dart';
import 'package:flutter/material.dart';

class TicketPage extends StatelessWidget {
  final List<ticketModel> tickets;

  const TicketPage({Key? key, required this.tickets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(title: Text("Ticket Console")),
      body: Center(
        child: SingleChildScrollView(child: dataTable(tickets)),
      ),
    );
  }
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              onSort: (i, b) {}),
          DataColumn(
              label: Text('Username',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              onSort: (i, b) {}),
          DataColumn(
              label: Text('Campus',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              onSort: (i, b) {}),
          DataColumn(
              label: Text('Issue',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              onSort: (i, b) {}),
          DataColumn(
              label: Text('Status',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              onSort: (i, b) {}),
          DataColumn(
              label: Text('',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
