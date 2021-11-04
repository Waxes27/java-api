import 'package:app_tut/ticketModel.dart';
import 'package:app_tut/ticket_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

class _HomePageState extends State<_HomePage> {
  @override
  void initState() {
    super.initState();
    fetchTickets();
  }

  final data = ticketModel();

  void _goToTickets() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return TicketPage(tickets: data.getTickets());
    }));
  }

  void fetchTickets() async {
    final response = await http.get(Uri.parse("http://localhost:4444/tickets"));
    List jsonOb = await json.decode(response.body);
    for (var item in jsonOb) {
      print(item);
      data.addTicket(ticketModel.fromJson(item));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Console"),
        ),
        body: Center(
          child: ElevatedButton(
            child: Text("Go to tickets page."),
            onPressed: () {
              _goToTickets();
            },
          ),
        ));
  }
}
