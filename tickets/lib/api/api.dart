import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';


var now = DateTime.now();
final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
final String formatted = formatter.format(now);

String ip = "102.221.36.216";
// String ip = "localhost";

Future createIssue(username, userIssue, userCampus, userFloor) async {
    print(now); // 2016-01-25

    Response data = await http.post(
      Uri.parse('http://$ip:4444/tickets'),
      body: jsonEncode(<String, String>{
        "author": username,
        "issue": userIssue.toString().toUpperCase(),
        "campus": userCampus,
        "floor": userFloor.toString().replaceAll("th", "").replaceAll("st", "")
          .replaceAll("rd", ""),
        "category": userIssue.toString().toUpperCase(),
        "date": formatted,
      }),
    );

    var referenceId = await jsonDecode(data.body)["referenceId"];

    print("RESPONSE FROM CREATE ISSUE: $referenceId");
    return referenceId;
  }
