import 'package:flutter/material.dart';
import 'package:tickets/pages/thankyou.dart';
import 'campus.dart';
import 'floor.dart';
import 'issues_page.dart';
import 'package:tickets/homepage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ConfirmationPage extends StatefulWidget{
  ConfirmationPageState createState() => ConfirmationPageState();
}

class ConfirmationPageState extends State<ConfirmationPage>{
  final List<String> listOfData = [usernameIn,issue,campus,floor,""];

  Future<http.Response> createIssue(username,userIssue,userCampus,userFloor) async {
    String ip = "102.221.36.216";
    return await http.post(
      Uri.parse('http://$ip:4444/tickets'),
      body: jsonEncode(<String, String>{
        "author": username,
        "issue": userIssue.toString().toUpperCase(),
        "campus": userCampus,
        "floor": userFloor.toString().replaceAll("th", ""),
        "category": userIssue,
      }),
    );
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
    if (index == 0){
    return ListTile(title: Text("Username: ${listOfData[index]}"));
    }
    if (index == 1){
    return ListTile(title: Text("Issue Category: ${listOfData[index]}"));
    }
    if (index == 2){
    return ListTile(title: Text("Campus: ${listOfData[index]}"));
    }
    if (index == 3){
    return ListTile(title: Text("Floor Number: ${listOfData[index]}"));
    }
    return ListTile(title: ElevatedButton(
      child: const Text("Confirm"),

      onPressed: (){
        createIssue(usernameIn, issue, campus, floor);
        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
          return EndPage();
        }));
      },
    ));
    
    
  }
}