import 'package:flutter/cupertino.dart';

enum Status { Completed, Pending, Incomplete }

Status stuff(String status) {
  dynamic states = {
    "incomplete": Status.Incomplete, 
    "pending": Status.Pending, 
    "completed": Status.Completed
    };
  return states[status];
}

class ticketModel extends ChangeNotifier {
  var userName;
  var problem;
  var id;
  // var date;
  var campus;
  var status;
  List<ticketModel> tickets = [];

  ticketModel(
      {this.id,
      this.userName,
      this.problem,
      // this.date,
      this.campus,
      this.status});

  factory ticketModel.fromJson(json) {
    var newTicket = ticketModel(
        id: int.parse(json["id"]),
        userName: json["username"],
        problem: json["issue"],
        // date: json["date"],
        campus: json["campus"],
        status: stuff(json['completed'].toLowerCase()));
    return newTicket;
  }

  String getUsername() => this.userName;
  String getCampus() => this.campus;
  String getProblem() => this.problem;
  int getID() => this.id;
  Status isCompleted() => this.status;
  // DateTime getCreationDate() => this.date;

  void completeTicket() => this.status = Status.Completed;
  void startTicket() => this.status = Status.Pending;

  void addTicket(ticketModel ticket) {
    this.tickets.add(ticket);
    notifyListeners();
  }

  void removeTicket(ticketModel ticket) {
    for (var item in tickets) {
      if (item.getID() == ticket.getID()) {
        tickets.remove(item);
      }
      notifyListeners();
    }
  }


  void dropAll() {
    this.tickets.clear();
    notifyListeners();
  }

  void pending() {
    this.status = Status.Pending;
    notifyListeners();
  }

  void complete() {
    this.status = Status.Completed;
    notifyListeners();
  }

  List<ticketModel> getTickets() {
    return this.tickets;
  }
}
