import 'package:flutter/cupertino.dart';

enum Status { COMPLETED, PENDING, INCOMPLETED }

Status getCategoryEnum(String status) {
  dynamic states = {
    "incomplete": Status.INCOMPLETED,
    "pending": Status.PENDING,
    "completed": Status.COMPLETED
  };
  return states[status];
}

class ticketModel extends ChangeNotifier {
  var userName;
  var problem;
  var referenceId;
  var id;
  var floor;
  var date;
  var campus;
  var status;
  var category;
  List<ticketModel> tickets = [];

  ticketModel(
      {this.id,
      this.referenceId,
      this.userName,
      this.problem,
      this.floor,
      this.date,
      this.campus,
      this.status,
      this.category});

  factory ticketModel.fromJson(json) {
    print(json);
    var newTicket = ticketModel(
        id: int.parse(json["id"]),
        referenceId: int.parse(json["referenceId"]),
        userName: json["username"],
        problem: json["issue"],
        floor: int.parse(json["floor"]),
        date: json["date"],
        campus: json["campus"],
        status: getCategoryEnum(json['completed'].toLowerCase()),
        category: json['category']);

    print(newTicket.getID());
    return newTicket;
  }

  String getUsername() => this.userName;
  String getCampus() => this.campus;
  String getProblem() => this.problem;
  int getID() => this.id;
  int getRefID() => this.referenceId;
  Status isCompleted() => this.status;
  String getCreationDate() => this.date;

  int getFloor() => this.floor;
  String getCategory() => this.category;

  void completeTicket() => this.status = Status.COMPLETED;
  void startTicket() => this.status = Status.PENDING;

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
    this.status = Status.PENDING;
    notifyListeners();
  }

  void complete() {
    this.status = Status.COMPLETED;
    notifyListeners();
  }

  List<ticketModel> getTickets() {
    return this.tickets;
  }
}
