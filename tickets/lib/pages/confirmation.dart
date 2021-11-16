import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tickets/pages/endpage.dart';
import 'campus.dart';
import 'floor.dart';
import 'issues_page.dart';
import 'package:tickets/homepage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// String ip = "102.221.36.216";
String ip = "localhost";

String referenceId = "";
class ConfirmationPage extends StatefulWidget{
  @override
  ConfirmationPageState createState() => ConfirmationPageState();
}

class ConfirmationPageState extends State<ConfirmationPage>{
  final List<String> listOfData = [usernameIn,issue,campus,floor,""];

  var now = DateTime.now();
  void createIssue(username,userIssue,userCampus,userFloor) async {
    

    print(now); // 2016-01-25

    Response data = await http.post(
      Uri.parse('http://$ip:4444/tickets'),
      body: jsonEncode(<String, String>{
        "author": username,
        "issue": userIssue.toString().toUpperCase(),
        "campus": userCampus,
        "floor": userFloor.toString().replaceAll("th", ""),
        "category": userIssue.toString().toUpperCase(),
        "date" : now.toString(),
      }),
    );

    referenceId = await jsonDecode(data.body)["referenceId"];
  }


  void getReferenceId(username,userIssue,userCampus,userFloor) async {
    http.post(
      Uri.parse('http://$ip:4444/ticket'),
      body: jsonEncode(<String, String>{
        "author": username,
        "issue": userIssue.toString().toUpperCase(),
        "campus": userCampus,
        "floor": userFloor.toString().replaceAll("th", ""),
        "category": userIssue.toString().toUpperCase(),
        "date" : now.toString(),
      }),
    );

      // print(queryString);
      // print(Uri.http('http://$ip:4444','/ticket/',queryString));

      // final uri = Uri.http('localhost:4444', '/ticket', queryString);
      // final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
      // final response = await http.get(uri, headers: headers);

    // Response res = await http.get(Uri.http('http://$ip:4444/ticket/',queryString));
    // Map body =await jsonDecode(res.body);
    // print(res.body);
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text("Here is your Ticket"),),
      body: Center(
        child: ListView.builder(itemCount: listOfData.length, itemBuilder: (context,index){
          return _buildRow(context, index);
        })
      
    ));
  }

  Widget _buildRow(BuildContext context,int index){
    switch (index) {
      case 0:
        return ListTile(title: Text("Username: ${listOfData[index]}"));
      case 1:
        return ListTile(title: Text("Issue Category: ${listOfData[index]}"));
      case 2:
        return ListTile(title: Text("Campus: ${listOfData[index]}"));
      case 3:
        return ListTile(title: Text("Floor Number: ${listOfData[index]}"));

      default:
      return ListTile(title: ElevatedButton(
      child: const Text("Confirm"),

      onPressed: (){
        createIssue(usernameIn, issue, campus, floor);
        getReferenceId(usernameIn, issue, campus, floor);


        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
          return EndPage();
        }));
      },
    ));
    }
  }
}