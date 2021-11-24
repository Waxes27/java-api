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
      "floor": userFloor
          .toString()
          .replaceAll("th", "")
          .replaceAll("nd", "")
          .replaceAll("rd", ""),
      "category": userIssue.toString().toUpperCase(),
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
      List stuff = jsonDecode("[{date=, issue=Python3 and Keyboard, campus=JHB, id=1, completed=INCOMPLETE, floor=4, category=HARDWARE, referenceId=1637773228687, username=kmthunzi}, {date=, issue=Bashrc, campus=JHB, id=2, completed=INCOMPLETE, floor=4, category=SOFTWARE, referenceId=1637773228910, username=ndumasi}, {date=, issue=Keyboard, campus=JHB, id=3, completed=INCOMPLETE, floor=6, category=HARDWARE, referenceId=1637773229196, username=kingV}, {date=, issue=Youtube crashed, campus=JHB, id=4, completed=INCOMPLETE, floor=5, category=LMS, referenceId=1637773229305, username=Vines}, {date=, issue=Vines is hassling me, campus=JHB, id=5, completed=INCOMPLETE, floor=5, category=SOFTWARE, referenceId=1637773229488, username=Youtube}, {date=, issue=Server not Found, campus=JHB, id=6, completed=INCOMPLETE, floor=6, category=HARDWARE, referenceId=1637773229596, username=APex}, {date=, issue=Need to upgrade to Javalin5, campus=JHB, id=7, completed=INCOMPLETE, floor=6, category=HARDWARE, referenceId=1637773229690, username=Javalin4}, {date=, issue=Not compatible with flutter, campus=JHB, id=8, completed=INCOMPLETE, floor=4, category=SOFTWARE, referenceId=1637773229799, username=Javalin5}, {date=, issue=New and fresh package, campus=JHB, id=9, completed=INCOMPLETE, floor=0, category=SOFTWARE, referenceId=1637773229997, username=Flutter}, {date=, issue=Need automation done on all floors, and DUrban campus is hungry for Network resolutions and CPT has Ruan...., campus=JHB, id=10, completed=INCOMPLETE, floor=0, category=LMS, referenceId=1637773230187, username=zakirah}]");
  return stuff;
}
