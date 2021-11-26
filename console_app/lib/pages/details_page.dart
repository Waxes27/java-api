import 'package:app_tut/ticketModel.dart';
import 'package:flutter/material.dart';

class DeatailsPage extends StatefulWidget {
  ticketModel ticket;

  var dynamicIcon;

  var dynamicColor;


  DeatailsPage({Key? key, required this.ticket, required this.dynamicIcon, required this.dynamicColor}) : super(key: key);

  @override
  _DeatailsPageState createState() => _DeatailsPageState();
}


class _DeatailsPageState extends State<DeatailsPage> {

    Icon _getIcon(ticket) {
    return widget.dynamicIcon(ticket);
  }


  Widget ticketDetails(ticketModel ticket ) {
    return Container(
    padding: const EdgeInsets.all(32),
      child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'Authored by: ${ticket.getUsername().toUpperCase()}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),
                ),
              ),
              Text(
                'Category: ${ticket.getCategory()}',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 15

                ),
              ),
               Text(
                'Created: ${ticket.getCreationDate().substring(0,10)} at ${ticket.getCreationDate().substring(11,16)}',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 15

                )
              ),
            ]
          )
        ),
      Text(
                "STATUS: ${ticket.isCompleted().toString().replaceAll("Status.", "")}",
                style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),
      )
      ]),
    );
  }

  Column _buildButtonColumn(Color? color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }


  Widget buttonSection () { 
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButtonColumn(Colors.blue[900], Icons.email, 'EMAIL'),
        _buildButtonColumn(Colors.blue[900], Icons.assignment_returned_outlined, 'ASSIGN'),
        _buildButtonColumn(Colors.blue[900], Icons.share, 'SHARE'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("T I C K E T   D E T A I L S") ,)),
      body: Center(child: Column(children: [
        ticketDetails(widget.ticket),
        Divider(
            height: 20,
            thickness: 5,
            indent: 20,
            endIndent: 20,
            color: widget.dynamicColor(widget.ticket),
        ),
        buttonSection()  
      ])),
    );
  }
}