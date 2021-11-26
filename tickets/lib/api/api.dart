import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'models/ticket.dart';

var now = DateTime.now();
final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
final String formatted = formatter.format(now);

String ip = "102.221.36.216";
// String ip = "localhost";

Future createIssue(username, userIssue, userCampus, userFloor,category) async {
  print(now); // 2016-01-25

  Response data = await http.post(
    Uri.parse('http://$ip:4444/tickets'),
    body: jsonEncode(<String, String>{
      "author": username,
      "issue": userIssue.toString(),
      "campus": userCampus,
      "floor": userFloor
          .toString()
          .replaceAll("th", "")
          .replaceAll("nd", "")
          .replaceAll("rd", "")
          .replaceAll("st", ""),
      "category": category,
      "date": formatted,
    }),
  );

  var referenceId = await jsonDecode(data.body)["referenceId"];

  print("RESPONSE FROM CREATE ISSUE: $referenceId");
  return referenceId;
}

Future getUserTickets(String username) async {
  Response data =
      await http.get(Uri.parse('http://$ip:4444/tickets/$username'));
  // print(data.body);
  List listOfDartJson = [];

  // List stuff = jsonDecode(data.body);
  print("STUFF HERE: ${stuff}");

  // listOfDartJson.add(ticketModel.fromJson(stuff[0]));

  print(stuff);
  return data.body;
}
