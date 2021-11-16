import 'package:flutter/material.dart';
import 'confirmation.dart';



class EndPage extends StatefulWidget {
  @override
  EndPageState createState() => EndPageState();
}

class EndPageState extends State<EndPage> {
  String id = "";
  String text = "Click here for ticket details";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: const Center(
      child: Text("Welcome to the WeThinkCode_ Ticketing System"),
    )),
      body: Column(
        children: <Widget>[ const Center(
        child: Text(
          "Your ticket has been logged...",
          style: TextStyle(
            fontSize: 24,
            fontFamily: "aria",
          ),
        ),
      ),

      const Padding(padding: EdgeInsets.all(50)),

      ElevatedButton(
        onPressed: (){
            // Redirect to User Tickets;
            // id = referenceId;
            setState(() {
              text = "Here is your reference ID: $referenceId";
            });
            // Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){

            // }));
        },
         child: Text(text)),

        // const Padding(padding: EdgeInsets.all(80)),


        // Text("Your your reference number is: ")





      
      ],
    )
    );
  }
}
