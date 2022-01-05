import 'package:flutter/material.dart';

class TicketDetail extends StatefulWidget {
  final reference;
  const TicketDetail({Key? key, this.reference}) : super(key: key);

  @override
  _TicketDetailState createState() => _TicketDetailState();
}

class _TicketDetailState extends State<TicketDetail> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: DataTable(
                    showBottomBorder: true,
                    horizontalMargin: 20,
                    columnSpacing: 102,
                    // dataRowColor: ,
                    // dividerThickness: ,

                    columns: const [
                      DataColumn(
                          label: Flexible(child: Text("Staff assigned"))),
                      DataColumn(label: Flexible(child: Text("Status"))),
                      DataColumn(
                          label: Flexible(child: Text("Reference Number"))),

                      DataColumn(label: Flexible(child: Text("Issue"))),
                      // DataColumn(label: Flexible(child: Text("Status"))),
                    ],
                    rows: [],
                  ),
      ),
    );
  }
}
